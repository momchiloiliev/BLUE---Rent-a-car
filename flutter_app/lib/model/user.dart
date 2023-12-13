import 'package:flutter_app/model/reservation.dart';

class User {
  String _id;

  User(this._id);

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  @override
  String toString() {
    return _id;
  }
}
