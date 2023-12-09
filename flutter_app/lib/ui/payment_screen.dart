import 'package:flutter/material.dart';
import 'package:flutter_app/ui/appbar.dart';
import 'package:flutter_app/ui/button.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Payment",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("cscsv"),
                  Text("cscsv"),
                  Text("cscsv"),
                ],
              ),
              Column(
                children: [
                  Text("cscsv"),
                  Text("cscsv"),
                  Text("cscsv"),
                ],
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                Column(
                  children: [
                    Text("jsbvbsivb"),
                    Text("chbsvbsh"),
                    Row(
                      children: [
                        Text("data"),
                        Text("data"),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          BlueButton(text: "Pay", route: "/orderConfirmed")
        ],
      ),
    );
  }
}
