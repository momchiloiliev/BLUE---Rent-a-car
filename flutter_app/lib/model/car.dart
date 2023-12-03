import 'package:flutter_app/model/reservation.dart';

import 'location.dart';

class Car {
  int id;
  String model;
  double price;
  int horsePower;
  double launchControlKm;
  int fullTankKm;
  String typeFuel;
  String status;
  List<Reservation> reservations;
  Location location;

  Car(
      {required this.id,
      required this.model,
      required this.price,
      required this.horsePower,
      required this.launchControlKm,
      required this.fullTankKm,
      required this.typeFuel,
      required this.status,
      required this.reservations,
      required this.location});
}
