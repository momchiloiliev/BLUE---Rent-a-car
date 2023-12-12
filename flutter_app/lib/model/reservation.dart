import 'package:flutter_app/model/payment.dart';

import 'location.dart';

class Reservation {
  // int _id;
  //int userId;
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
    // required this.userId,
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
    return 'Reservation{_carId: $_carId, _reserveDate: $_reserveDate, _driver: $_driver, _babySeat: $_babySeat, _totalPrice: $_totalPrice, _name: $_name, _email: $_email, _phone: $_phone, _pickupLocation: $_pickupLocation, _returnLocation: $_returnLocation}';
  }

// int get id => _id;
}
