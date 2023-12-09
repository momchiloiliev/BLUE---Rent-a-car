import 'package:flutter/material.dart';
import 'package:flutter_app/ui/address_container.dart';
import 'package:flutter_app/ui/appbar.dart';
import 'package:flutter_app/ui/reservation_car_details.dart';
import 'package:flutter_app/ui/shadow_button.dart';

class YourReservationsScreen extends StatefulWidget {
  const YourReservationsScreen({super.key});

  @override
  State<YourReservationsScreen> createState() => _YourReservationsScreenState();
}

class _YourReservationsScreenState extends State<YourReservationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Your Reservations",
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 15),
              child: buildAddressContainer(context, 50)),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return buildCarDetailsContainer(
                  context,
                  "Cancel Reservation",
                );
              },
            ),
          ),
          shadowButton("Back to Home", "/carList")
        ],
      ),
    );
  }
}
