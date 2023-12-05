import 'package:flutter/material.dart';

import 'appbar.dart';
import 'button.dart';

class PaymentOptionScreen extends StatefulWidget {
  const PaymentOptionScreen({super.key});

  @override
  State<PaymentOptionScreen> createState() => _PaymentOptionScreenState();
}

class _PaymentOptionScreenState extends State<PaymentOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Payment Option"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Agree to our terms and conditions",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Agree"),
                    ),
                    Text(
                      "Choose your payment method",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (newValue) {}),
                      Text('Checkbox 1'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (newValue) {}),
                      Text('Checkbox 1'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (newValue) {}),
                      Text('Checkbox 1'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (newValue) {}),
                      Text('Checkbox 1'),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your PickUp Address",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "City, Country",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Change"),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    "Price Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text("Price 1 item"),
                          Text("Price 1 item"),
                        ],
                      ),
                      Text("3000")
                    ],
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Price",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "3000MKD",
              ),
            ],
          ),
          BlueButton(text: "Checkout", route: "/payment")
        ],
      ),
    );
  }
}
