import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/car.dart';
import '../model/reservation.dart';
import 'package:flutter_app/model/reservation.dart';
import 'package:flutter_app/deviceUtils.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/ui/shadow_button.dart';

late Stream<QuerySnapshot<Map<String, dynamic>>> firestoreDb;

  bool isReservationBeforeToday(Timestamp reservationTimestamp) {
    DateTime now = DateTime.now();
    DateTime reservationDate = reservationTimestamp.toDate().toLocal();
    // print(reservationDate);
    return reservationDate.isBefore(DateTime(now.year, now.month, now.day));
  }

Widget buildCarDetailsContainer(
    BuildContext context, Map<String, dynamic> reservation,) {

    String formatDateTime(Timestamp timestamp) {
      DateTime dateTime = timestamp.toDate().toLocal();
      return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    }

    Timestamp reservationTimestamp = reservation['reserveDate'];
    bool isBeforeToday = isReservationBeforeToday(reservationTimestamp);
    bool isAfterToday = !isReservationBeforeToday(reservationTimestamp);


  return FutureBuilder(
      future: getCarData(reservation['carId']),
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
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 5,
                  offset: const Offset(0, 3),
                ),
                const BoxShadow(
                  color: Colors.white,
                  blurRadius: 15,
                  spreadRadius: 5,
                  offset: Offset(0, 3),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 20,
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
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, bottom: 30.0, top: 30.0),
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
                                      fontSize: 16, color: Colors.black54)),
                              Text(
                                "${car.price * 50}/per day",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87),
                              ),
                              Text("Days: ${reservation['days']}",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              Text("Total Price: ${reservation['totalPrice']}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),),
                              Text(
                                isAfterToday
                                    ? "Pickup: ${DateFormat('yyyy-MM-dd HH:mm').format(reservation['reserveDate'].toDate())}"
                                    : "Return: ${DateFormat('yyyy-MM-dd HH:mm').format(reservation['returnDate'].toDate())}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                  if(isAfterToday)
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.2))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                            // Cancel reservation logic
                          // Add your code to cancel the reservation here
                          child: Text('Cancel Reservation', style: TextStyle(color: Colors.red, fontSize: 16),),

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
