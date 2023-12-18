import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/car.dart';
import '../model/reservation.dart';
import 'package:flutter_app/model/reservation.dart';
import 'package:flutter_app/deviceUtils.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/ui/shadow_button.dart';

class ReservationDetails extends StatefulWidget {
  const ReservationDetails({
    Key? key,
    required this.reservation,
    required this.reservationId,
    required this.refreshCallback,
  }) : super(key: key);

  final Map<String, dynamic> reservation;
  final String reservationId;
  final VoidCallback refreshCallback;

  @override
  State<ReservationDetails> createState() => _ReservationDetailsState();
}

class _ReservationDetailsState extends State<ReservationDetails> {
  late Timestamp reservationTimestamp;
  late bool isBeforeToday;
  late bool isAfterToday;

  @override
  void initState() {
    super.initState();
    initializeVariables();
  }

  void deleteReservation() async {
    try {
      await removeReferencesOnReservationDeletion(widget.reservationId);
      // Optionally, update the UI or perform any other action after deletion
      setState(() {
        // Update the state or perform any post-deletion actions if needed
      });
      print('Reservation ${widget.reservationId} was successfully deleted.');
      widget.refreshCallback();
    } catch (error) {
      print('Error deleting reservation: $error');
      // Handle the error accordingly
    }
  }

  void initializeVariables() {
    reservationTimestamp = widget.reservation['reserveDate'];
    isBeforeToday = isReservationBeforeToday(reservationTimestamp);
    isAfterToday = !isReservationBeforeToday(reservationTimestamp);
  }

  String formatDateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate().toLocal();
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCarData(widget.reservation['carId']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No car data available.'));
          } else {
            Car car = snapshot.data!;
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    blurRadius: 30,
                    spreadRadius: 10,
                    offset: Offset(0, 3),
                  ),
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              // height: MediaQuery.of(context).size.height * 0.28,
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: 8.0,
                            left: 8.0,
                            bottom: isAfterToday ? 30.0 : 10.0,
                            top: 30.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Image.network(
                                  car.imageLink, //tuka od baza
                                  width: 150,
                                  height: 80,
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(car.model, //tuka od baza
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black54)),
                                Text(
                                  "${car.price * 50}/per day",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87),
                                ),
                                Text(
                                  "Days: ${widget.reservation['days']}",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Total Price: ${widget.reservation['totalPrice']}",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  isAfterToday
                                      ? "Pickup: ${DateFormat('yyyy-MM-dd HH:mm').format(widget.reservation['reserveDate'].toDate())}"
                                      : "Return: ${DateFormat('yyyy-MM-dd HH:mm').format(widget.reservation['returnDate'].toDate())}",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (isAfterToday)
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey, width: 0.2))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              deleteReservation();
                            },
                            // Cancel reservation logic
                            // Add your code to cancel the reservation here
                            child: Text(
                              'Cancel Reservation',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (!isAfterToday)
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey, width: 0.3))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ongoing Reservation',
                            style: TextStyle(color: Colors.green, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          }
        });
  }
}

bool isReservationBeforeToday(Timestamp reservationTimestamp) {
  DateTime now = DateTime.now();
  DateTime reservationDate = reservationTimestamp.toDate().toLocal();
  return reservationDate.isBefore(now);
}
