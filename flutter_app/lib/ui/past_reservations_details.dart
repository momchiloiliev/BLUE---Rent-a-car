import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/reservation.dart';

import '../model/car.dart';

Widget buildCarDetailsContainerPast(
    BuildContext context, Map<String, dynamic> reservationRef) {
  return FutureBuilder(
      future: getCarData(reservationRef['carId']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No car data available.'));
        } else {
          Car car = snapshot.data!;
          Reservation reservation =
              Reservation.fromSnapshot(reservationRef as Map<String, dynamic>);
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
            // height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, bottom: 8.0, top: 8.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Image.network(
                                car.imageLink,
                                width: 150,
                                height: 80,
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(car.model,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54)),
                              Text(
                                "${car.price * 50}/per day",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87),
                              ),
                              Row(
                                children: [
                                  Text("Days: ${reservation.days}",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                      "Date: ${reservation.reserveDate.toString().substring(0, 10)}",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      });
}
