import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/payment.dart';
import 'package:flutter_app/model/user.dart';

import 'location.dart';

class Reservation {
  // int _id;
  String _user;
  String _carId;
  int _days;
  DateTime _reserveDate;
  DateTime _returnDate;
  bool _driver;
  bool _babySeat;
  int _totalPrice;
  String _name;
  String _email;
  String _phone;
  String _pickupLocation;
  String _returnLocation;
  //Payment payment;

  Reservation(
    this._user,
    this._carId,
    this._days,
    this._driver,
    this._babySeat,
    this._totalPrice,
    this._reserveDate,
    this._returnDate,
    this._name,
    this._email,
    this._phone,
    this._pickupLocation,
    this._returnLocation,
    // required this.payment
  );

  factory Reservation.fromSnapshot(Map<String, dynamic> data) {
    return Reservation(
      data['userId'],
      data['carId'],
      data['days'],
      data['driver'],
      data['babySeat'],
      data['totalPrice'],
      data['reserveDate'].toDate(),
      data['returnDate'].toDate(),
      data['name'],
      data['email'],
      data['phone'],
      data['pickupLocation'],
      data['returnLocation'],
    );
  }

  String get user => _user;

  set user(String value) {
    _user = value;
  }

  int get days => _days;

  set days(int value) {
    _days = value;
  }

  DateTime get returnDate => _returnDate;

  set returnDate(DateTime value) {
    _returnDate = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  set returnLocation(String value) {
    _returnLocation = value;
  }

  set pickupLocation(String value) {
    _pickupLocation = value;
  }

  set totalPrice(int value) {
    _totalPrice = value;
  }

  set babySeat(bool value) {
    _babySeat = value;
  }

  set driver(bool value) {
    _driver = value;
  }

  set reserveDate(DateTime value) {
    _reserveDate = value;
  }

  set carId(String value) {
    _carId = value;
  }
  //
  // set id(int value) {
  //   _id = value;
  // }

  String get returnLocation => _returnLocation;

  String get pickupLocation => _pickupLocation;

  int get totalPrice => _totalPrice;

  bool get babySeat => _babySeat;

  bool get driver => _driver;

  DateTime get reserveDate => _reserveDate;

  String get carId => _carId;

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  @override
  String toString() {
    return 'Reservation{_userId: $_user, _carId: $_carId, _days: $_days, _reserveDate: $_reserveDate, _returnDate: $_returnDate, _driver: $_driver, _babySeat: $_babySeat, _totalPrice: $_totalPrice, _name: $_name, _email: $_email, _phone: $_phone, _pickupLocation: $_pickupLocation, _returnLocation: $_returnLocation}';
  }

  Future<void> addReservationToFirestore() async {
    try {
      // Convert reservation details to a Map
      Map<String, dynamic> reservationData = {
        'userId': _user,
        'carId': _carId,
        'days': _days,
        'reserveDate': _reserveDate,
        'returnDate': _returnDate,
        'driver': _driver,
        'babySeat': _babySeat,
        'totalPrice': _totalPrice,
        'name': _name,
        'email': _email,
        'phone': _phone,
        'pickupLocation': _pickupLocation,
        'returnLocation': _returnLocation,
      };

      // Get references to Firestore collections
      CollectionReference reservations =
          FirebaseFirestore.instance.collection('reservations');
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      CollectionReference cars = FirebaseFirestore.instance.collection('cars');

      // Check if the reservation already exists in the 'reservations' collection
      QuerySnapshot querySnapshot = await reservations
          .where('userId', isEqualTo: _user)
          .where('carId', isEqualTo: _carId)
          .where('reserveDate', isEqualTo: _reserveDate)
          .where('returnDate', isEqualTo: _returnDate)
          .get();

      // If the same reservation exists, don't add it again
      if (querySnapshot.docs.isNotEmpty) {
        print('Reservation already exists.');
        return;
      }

      // Retrieve the car document reference using _carId
      DocumentReference carDocRef = cars.doc(_carId);
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
      reservedDates.add(date);
    }
  });

  return reservedDates;
}
