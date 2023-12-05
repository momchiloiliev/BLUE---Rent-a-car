import "package:flutter/material.dart";
import "package:flutter_app/ui/appbar.dart";
import "package:flutter_app/ui/button.dart";

class YourSelectionScreen extends StatefulWidget {
  const YourSelectionScreen({super.key});

  @override
  State<YourSelectionScreen> createState() => _YourSelectionScreenState();
}

class _YourSelectionScreenState extends State<YourSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Your Selection"),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Image(
                        image: AssetImage("images/bmw_amg.png"),
                        width: 80,
                        height: 80,
                      ),
                    ],
                  ),
                  SizedBox(
                      width: 10), // Adjust the space between image and text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Car Name"),
                      Text("Car Model"),
                      Row(
                        children: [
                          Text("Rent: \$200"),
                          InkWell(
                            onTap: () {
                              // Add your remove logic here
                            },
                            child: Text(
                              "Remove",
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 10), // Adjust the space between columns
            ],
          ),
          Row(
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
          BlueButton(text: "Continue to Payment", route: "/paymentOption")
        ],
      ),
    );
  }
}
