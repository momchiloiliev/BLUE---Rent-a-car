import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.width * 0.37,
              child: const ColoredBox(
                color: Colors.blue,
                child: Center(
                  child: Text(
                    "BLUE",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 85,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.35,
            child: const Column(
              children: [
                Center(
                  child: Text(
                    "BEST CARS",
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 50,
                      fontFamily: "Arvo-Bold",
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "FOR RENT",
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 50,
                      fontFamily: "Arvo-Bold",
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 270,
            child: Transform.translate(
              offset: const Offset(10, -20),
              child: const Image(
                image: AssetImage("images/mercedes.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/pickBrand");
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  foregroundColor: Colors.white,
                  fixedSize: const Size(215, 46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              child: const Text(
                'Rent a car',
                style: TextStyle(fontFamily: "Arvo-Regular", fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
