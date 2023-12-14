import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/car.dart';
import '../model/reservation.dart';
import 'package:flutter_app/model/reservation.dart';
import 'package:flutter_app/deviceUtils.dart';
late Stream<QuerySnapshot<Map<String, dynamic>>> firestoreDb;

Widget buildCarDetailsContainer(BuildContext context, String buttonText) {
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
                  const Column(
                    children: [
                      Image(
                        image: AssetImage('images/bmw_amg.png'),//tuka od baza
                        width: 150,
                        height: 80,
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("status: incoming", style: TextStyle(color: Colors.green, fontSize: 18),),
                      const Text("BMW AMG", //tuka od baza
                          style:
                              TextStyle(fontSize: 16, color: Colors.black54)),
                      Text(
                        "3000/per day",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87),
                      ),
                      Row(
                        children: [
                          const Text("Days: 1",
                              style: TextStyle(
                                fontSize: 16,
                              )),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.arrow_drop_up,
                                  size: 15,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 15,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
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
              border: Border(top: BorderSide(color: Colors.grey, width: 0.2))),
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
