import 'package:flutter/material.dart';
import 'package:flutter_app/ui/appbar.dart';
import 'package:flutter_app/ui/shadow_button.dart';

class OrderConfirmedScreen extends StatefulWidget {
  const OrderConfirmedScreen({super.key});

  @override
  State<OrderConfirmedScreen> createState() => _OrderConfirmedScreenState();
}

class _OrderConfirmedScreenState extends State<OrderConfirmedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Payment",
      ),
      body: Column(
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
                Padding(
                  padding: EdgeInsets.only(
                      top: 80, left: MediaQuery.sizeOf(context).width * 0.22),
                  child: const Column(
                    children: [
                      Image(image: AssetImage("images/Done.png")),
                      Text(
                        "Order Confirmed",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 14, bottom: 10),
                        child: const Text(
                          "Delivery Address",
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
                        padding: const EdgeInsets.only(left: 14, top: 14),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "YourName",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "YourAddress",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
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
                                  "  10019191",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          shadowButton("Your Reservations", "/yourReservations")
        ],
      ),
    );
  }
}
