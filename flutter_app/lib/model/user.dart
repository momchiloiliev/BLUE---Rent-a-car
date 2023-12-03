import 'package:flutter_app/model/reservation.dart';

class User {
  int id;
  String name;
  String email;
  String password;
  String phone;
  List<Reservation> reservations;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.phone,
      required this.reservations});
}
