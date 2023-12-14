import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/car.dart';
import '../model/reservation.dart';
import 'package:flutter_app/model/reservation.dart';
import 'package:flutter_app/deviceUtils.dart';

late Stream<QuerySnapshot<Map<String, dynamic>>> firestoreDb;

Widget buildCarDetailsContainer(
    BuildContext context, Map<String, dynamic> reservation, String buttonText) {
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
            height: MediaQuery.of(context).size.height * 0.28,
            // print(reservation);
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, bottom: 8.0, top: 50.0),
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
                              Text(
                                "status: incoming",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 18),
                              ),
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
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                        child: Text(buttonText,
                            style: TextStyle(color: Colors.grey, fontSize: 16)),
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
