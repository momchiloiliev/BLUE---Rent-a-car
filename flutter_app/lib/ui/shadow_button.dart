import 'package:flutter/material.dart';

import 'button.dart';

Widget shadowButton(String text, String route) {
  return Container(
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
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlueButton(text: text, route: route),
      ],
    ),
  );
}
