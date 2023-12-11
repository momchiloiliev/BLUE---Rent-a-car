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

  Car(
      {required this.id,
      required this.model,
      required this.price,
      required this.horsePower,
      required this.launchControlKm,
      required this.fullTankKm,
      required this.typeFuel,
      required this.reserved,
      required this.imageLink});
}
