import 'package:flutter_app/model/payment.dart';

import 'location.dart';

class Reservation {
  int id;
  int userId;
  int carId;
  String status;
  DateTime reserveDate;
  int reservationDays;
  Location pickupLocation;
  Location returnLocation;
  Payment payment;

  Reservation(
      {required this.id,
      required this.userId,
      required this.carId,
      required this.status,
      required this.reserveDate,
      required this.reservationDays,
      required this.pickupLocation,
      required this.returnLocation,
      required this.payment});
}
