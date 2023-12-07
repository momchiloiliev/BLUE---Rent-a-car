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
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
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
                            "City, Country",//todo: city,contry map from previous screen
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
                    padding: const EdgeInsets.only(right:14.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,),
                        onPressed: () {},//todo: back to before screen to change or new screen appears when clicks
                        child: Text("Change", style: TextStyle(color: Colors.white,),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade100),
            ),
            height: 480,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0, top:50.0),
                  child: Row(
                    children: [
                      const Column(
                        children: [
                          Image(
                            image: AssetImage("images/bmw_amg.png"),
                            width: 120,
                            height: 120,
                          ),
                        ],
                      ),
                      const SizedBox(
                          width: 10), // Adjust the space between image and text
                      Column(
                        children: [
                          Text("BMW GLA45", style: TextStyle(fontSize: 16, fontFamily:'Avro',)),
                          Text("3000MKD/day", style: TextStyle(fontSize: 22, fontFamily: 'Avro',),),
                          Text("Days: 1", style: TextStyle(fontSize: 16,fontFamily:"Avro", )),
                          OutlinedButton(onPressed: () {}, child: Text("Remove",style: TextStyle(color: Colors.red),),),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,

                      ),
                    ],
                  ),
                ),
                // SizedBox(width: 10), // Adjust the space between columns
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade100),),
            height: 100,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Price", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      Text("Delivery Fee", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      Text("Total", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("3000MKD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      Text("600MKD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      Text("3600MKD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:18.0),
            child: BlueButton(text: "Continue to Payment", route: "/paymentOption",),
          ),
        ],
      ),
    );
  }
}
