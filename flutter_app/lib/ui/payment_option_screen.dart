import 'package:flutter/material.dart';

import 'appbar.dart';
import 'button.dart';

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
      appBar: CustomAppBar(title: "Payment Option"),
      body: Container(
        color: Colors.grey.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 390,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade100),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
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
                                child: Text(
                                  'terms and conditions',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              onPressed:
                                  () {}, //todo: onclick change button text to -> agreed
                              child: const Text(
                                "Agree",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.white,
                    width: 390,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Choose your payment method:", style:TextStyle(fontSize: 18)),
                        ),
                        RadioListTile(
                          activeColor: Colors.blue,
                          value: 1,
                          groupValue: selectedRadio,
                          title: Text('Debit/Credit Card'),
                          onChanged: (val) {
                            setSelectedRadio(val!);
                          },
                        ),
                        RadioListTile(
                          activeColor: Colors.blue,
                          value: 2,
                          groupValue: selectedRadio,
                          title: Text('Netbanking'),
                          onChanged: (val) {
                            setSelectedRadio(val!);
                          },
                        ),
                        RadioListTile(
                          activeColor: Colors.blue,
                          value: 3,
                          groupValue: selectedRadio,
                          title: Text('Stripe'),
                          onChanged: (val) {
                            setSelectedRadio(val!);
                          },
                        ),
                        RadioListTile(
                          activeColor: Colors.blue,
                          value: 4,
                          groupValue: selectedRadio,
                          title: Text('Wallet'),
                          onChanged: (val) {
                            setSelectedRadio(val!);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(14.0),
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
                            "City, Country", //todo: city,contry map from previous screen
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed:
                            () {}, //todo: back to before screen to change or new screen appears when clicks
                        child: Text(
                          "Change",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  color: Colors.white,
                  width: maxWidth,
                  height: 100,
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price Details",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Price (1 item)",),
                            Text("3000 MKD"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivery Fee",),
                            Text("600 MKD"),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              color:Colors.white,
              child: const Padding(
                padding:  EdgeInsets.all(14.0),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Amount",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "3600MKD",
                    ),
                  ],
                ),
              ),
            ),
            const BlueButton(text: "Checkout", route: "/payment")
          ],
        ),
      ),
    );
  }
}
