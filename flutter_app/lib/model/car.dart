import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/reservation.dart';

import 'location.dart';

class Car {
  String id;
  String model;
  int price;
  int horsePower;
  double launchControlKm;
  int fullTankKm;
  String typeFuel;
  bool reserved;
  String imageLink;
  String transmission;

  Car(
      {required this.id,
      required this.model,
      required this.price,
      required this.horsePower,
      required this.launchControlKm,
      required this.fullTankKm,
      required this.typeFuel,
      required this.reserved,
      required this.imageLink,
      required this.transmission,});

  factory Car.fromMap(String carId, Map<String, dynamic> carData) {
    return Car(
      id: carId,
      model: carData['model'],
      price: carData['price'],
      horsePower: carData['horsePower'],
      launchControlKm: carData['launchControlKm'],
      fullTankKm: carData['fullTankKm'],
      typeFuel: carData['typeFuel'],
      reserved: carData['reserved'],
      imageLink: carData['imageLink'],
      transmission: carData['transmission'],
    );
  }
}

Future<Car?> getCarData(String carId) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("cars").doc(carId).get();

    if (snapshot.exists) {
      Map<String, dynamic> carData = snapshot.data()!;
      return Car.fromMap(carId, carData);
    } else {
      print('Car with ID $carId does not exist.');
      return null;
    }
  } catch (e, stackTrace) {
    print('Error fetching car data for ID $carId: $e\n$stackTrace');
    return null;
  }
}
