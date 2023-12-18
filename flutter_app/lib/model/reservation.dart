import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  String user;
  String carId;
  int days;
  DateTime reserveDate;
  DateTime returnDate;
  bool driver;
  bool babySeat;
  int totalPrice;
  String pickupLocation;
  String returnLocation;

  Reservation(
      {required this.user,
      required this.carId,
      required this.days,
      required this.reserveDate,
      required this.returnDate,
      required this.driver,
      required this.babySeat,
      required this.totalPrice,
      required this.pickupLocation,
      required this.returnLocation});

  factory Reservation.fromSnapshot(Map<String, dynamic> data) {
    return Reservation(
      user: data['userId'],
      carId: data['carId'],
      days: data['days'],
      driver: data['driver'],
      babySeat: data['babySeat'],
      totalPrice: data['totalPrice'],
      reserveDate: data['reserveDate'].toDate(),
      returnDate: data['returnDate'].toDate(),
      pickupLocation: data['pickupLocation'],
      returnLocation: data['returnLocation'],
    );
  }

  @override
  String toString() {
    return 'Reservation{user: $user, carId: $carId, days: $days, reserveDate: $reserveDate, returnDate: $returnDate, driver: $driver, babySeat: $babySeat, totalPrice: $totalPrice, pickupLocation: $pickupLocation, returnLocation: $returnLocation}';
  }

  Future<void> addReservationToFirestore() async {
    try {
      // Convert reservation details to a Map
      Map<String, dynamic> reservationData = {
        'userId': user,
        'carId': carId,
        'days': days,
        'reserveDate': reserveDate,
        'returnDate': returnDate,
        'driver': driver,
        'babySeat': babySeat,
        'totalPrice': totalPrice,
        'pickupLocation': pickupLocation,
        'returnLocation': returnLocation,
      };

      // Get references to Firestore collections
      CollectionReference reservations =
          FirebaseFirestore.instance.collection('reservations');
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      CollectionReference cars = FirebaseFirestore.instance.collection('cars');

      // Check if the reservation already exists in the 'reservations' collection
      QuerySnapshot querySnapshot = await reservations
          .where('userId', isEqualTo: user)
          .where('carId', isEqualTo: carId)
          .where('reserveDate', isEqualTo: reserveDate)
          .where('returnDate', isEqualTo: returnDate)
          .get();

      // If the same reservation exists, don't add it again
      if (querySnapshot.docs.isNotEmpty) {
        print('Reservation already exists.');
        return;
      }

      // Retrieve the car document reference using _carId
      DocumentReference carDocRef = cars.doc(carId);
      DocumentReference userDocRef = users.doc(user);

      // Add the reservation to the 'reservations' collection
      DocumentReference reservationRef =
          await reservations.add(reservationData);

      // Add a reference to the reservation in the 'users' collection
      await userDocRef.update({
        'reservations': FieldValue.arrayUnion([reservationRef])
      });

      // Add a reference to the reservation in the 'cars' collection
      await carDocRef.update({
        'reservations': FieldValue.arrayUnion([reservationRef])
      });
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error adding reservation: $e');
      throw e;
    }
  }
}

Future<List<DateTime>> fetchReservedDates(String carId) async {
  List<DateTime> reservedDates = [];

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('reservations')
      .where('carId',
          isEqualTo: carId) // Assuming 'car.id' represents the specific car
      .get();

  querySnapshot.docs.forEach((doc) {
    DateTime reserveDate = (doc['reserveDate'] as Timestamp).toDate();
    DateTime returnDate = (doc['returnDate'] as Timestamp).toDate();

    for (DateTime date = reserveDate;
        date.isBefore(returnDate) || date.isAtSameMomentAs(returnDate);
        date = date.add(Duration(days: 1))) {
      if (date.isAfter(DateTime.now())) reservedDates.add(date);
    }
  });

  return reservedDates;
}

Future<void> removeReferencesOnReservationDeletion(
    String deletedReservationId) async {
  final reservationRef = FirebaseFirestore.instance
      .collection('reservations')
      .doc(deletedReservationId);

  try {
    final reservationDoc = await reservationRef.get();

    if (reservationDoc.exists) {
      final carId = reservationDoc.get('carId');
      final userId = reservationDoc.get('userId');

      // Delete the reservation document
      await reservationRef.delete();

      // Create a DocumentReference using the deleted reservation ID
      final deletedReservationRef =
          FirebaseFirestore.instance.doc('reservations/$deletedReservationId');

      // Remove the reservation reference from the car
      final carRef = FirebaseFirestore.instance.collection('cars').doc(carId);
      await carRef.update({
        'reservations': FieldValue.arrayRemove([deletedReservationRef])
      });

      // Remove the reservation reference from the user
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      await userRef.update({
        'reservations': FieldValue.arrayRemove([deletedReservationRef])
      });

      print('Reservation and references removed successfully.');
    }
  } catch (e) {
    print('Error deleting reservation: $e');
    // Handle errors here
  }
}
