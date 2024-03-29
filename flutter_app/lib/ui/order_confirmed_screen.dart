import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/appbar.dart';
import 'package:flutter_app/ui/shadow_button.dart';

import '../model/car.dart';
import '../model/reservation.dart';
import '../model/user.dart';

class OrderConfirmedScreen extends StatefulWidget {
  const OrderConfirmedScreen({super.key});

  @override
  State<OrderConfirmedScreen> createState() => _OrderConfirmedScreenState();
}

class _OrderConfirmedScreenState extends State<OrderConfirmedScreen> {
  late Reservation reservation =
      ModalRoute.of(context)!.settings.arguments as Reservation;
  @override
  Widget build(BuildContext context) {
    reservation.addReservationToFirestore();

    return Scaffold(
        appBar: const CustomAppBar(
          title: "Payment",
        ),
        body: FutureBuilder(
          future: Future.wait([
            getCarData(reservation.carId),
            getUserDocument(reservation.user),
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('No data available.'));
            } else {
              Car car = snapshot.data![0] as Car;
              DocumentSnapshot userSnapshot =
                  snapshot.data![1] as DocumentSnapshot;
              // Convert the DocumentSnapshot to a User object
              User user = User.fromDocumentSnapshot(userSnapshot);

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 15,
                          offset: const Offset(0, 3),
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          blurRadius: 15,
                          spreadRadius: 4,
                          offset: Offset(0, 3),
                        ),
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 15,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Column(
                          children: [
                            Center(child: Image(image: AssetImage("images/Done.png"))),
                            Text(
                              "Rental Confirmed",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 14, ),
                                child: Text(
                                  "Rental Details",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.grey, width: 0.4))),
                                padding:
                                    const EdgeInsets.only(left: 14, top: 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Name:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "  ${user.name}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Mobile:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "  ${user.phone}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Car:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "  ${car.model}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Pick Up Address:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis
                                                .horizontal, // Allow horizontal scrolling
                                            child: Text(
                                              reservation.pickupLocation,
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Pick Up Date:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "  ${reservation.reserveDate.toString().substring(0, 10)}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Rental days:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "  ${reservation.days}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Return Date:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "  ${reservation.returnDate.toString().substring(0, 10)}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Return Address:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis
                                                .horizontal, // Allow horizontal scrolling
                                            child: Text(
                                              reservation.returnLocation,
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Total Price:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "  ${reservation.totalPrice}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 15,
                          offset: const Offset(0, 3),
                        ),

                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, "/yourReservations",
                                    arguments: reservation.user);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Text(
                                "Your Reservations",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
          },
        ));
  }
}
