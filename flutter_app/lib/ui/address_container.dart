import 'package:flutter/material.dart';

Widget buildAddressContainer(BuildContext context, double padding) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 15,
          spreadRadius: 10,
          offset: const Offset(0, 3),
        ),
        const BoxShadow(
          color: Colors.white,
          blurRadius: 15,
          spreadRadius: 15,
          offset: Offset(0, 3),
        ),
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 15,
          spreadRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.only(top: padding),
      child: Row(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Pick Up Address',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'City, Country', //todo: city,contry map from previous screen
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/addPickUpAddress");
                },
                child: const Text(
                  'Change',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
