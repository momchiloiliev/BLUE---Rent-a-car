import 'package:flutter/material.dart';
import 'package:flutter_app/ui/shadow_button.dart';

import 'address_container.dart';
import 'appbar.dart';

class PaymentOptionScreen extends StatefulWidget {
  const PaymentOptionScreen({super.key});

  @override
  State<PaymentOptionScreen> createState() => _PaymentOptionScreenState();
}

class _PaymentOptionScreenState extends State<PaymentOptionScreen> {
  int selectedRadio = 0;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const CustomAppBar(title: "Payment Option"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
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
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Agree to our ',
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            //todo: terms and conditions link, or screen, or popup with button OK
                            // Navigator.push(
                            //   context,
                            //
                            //   MaterialPageRoute(
                            //     builder: (context) => TermsAndConditionsScreen(),
                            //   ),
                            // );
                          },
                          child: const Text(
                            'Terms and conditions',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed:
                            () {}, //todo: onclick change button text to -> agreed
                        child: const Text(
                          "Agree",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 15, left: 20, bottom: 10),
                margin: const EdgeInsets.only(bottom: 15),
                child: const Text("Choose your payment method:",
                    style: TextStyle(fontSize: 18)),
              ),
              Container(
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
                      spreadRadius: 15,
                      offset: Offset(0, 3),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    RadioListTile(
                      activeColor: Colors.blue,
                      value: 1,
                      groupValue: selectedRadio,
                      title: const Text('Debit/Credit Card'),
                      onChanged: (val) {
                        setSelectedRadio(val!);
                      },
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey, width: 0.4))),
                      child: RadioListTile(
                        activeColor: Colors.blue,
                        value: 2,
                        groupValue: selectedRadio,
                        title: const Text('Netbanking'),
                        onChanged: (val) {
                          setSelectedRadio(val!);
                        },
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.5),
                      )),
                      child: RadioListTile(
                        activeColor: Colors.blue,
                        value: 3,
                        groupValue: selectedRadio,
                        title: const Text('Stripe'),
                        onChanged: (val) {
                          setSelectedRadio(val!);
                        },
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.5),
                      )),
                      child: RadioListTile(
                        activeColor: Colors.blue,
                        value: 4,
                        groupValue: selectedRadio,
                        title: const Text('Wallet'),
                        onChanged: (val) {
                          setSelectedRadio(val!);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          buildAddressContainer(context, 0),
          Container(
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
                  spreadRadius: 15,
                  offset: Offset(0, 3),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  width: maxWidth,
                  padding: const EdgeInsets.all(14),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Price Details",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Price (1 item)",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "3000 MKD",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery Fee",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "600 MKD",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      border: const Border(
                          top: BorderSide(color: Colors.grey, width: 0.5))),
                  padding: const EdgeInsets.only(
                      bottom: 14, left: 14, right: 14, top: 10),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "3600MKD",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          shadowButton("Checkout", "/payment")
        ],
      ),
    );
  }
}
