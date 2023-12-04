import 'package:flutter/material.dart';

class BrandPickScreen extends StatefulWidget {
  const BrandPickScreen({Key? key}) : super(key: key);

  @override
  _BrandPickScreenState createState() => _BrandPickScreenState();
}

class _BrandPickScreenState extends State<BrandPickScreen> {
  Map<int, Color> buttonColors = {
    1: Colors.white,
    2: Colors.white,
    3: Colors.white,
    4: Colors.white,
  };

  void changeColor(int index) {
    setState(() {
      buttonColors
          .updateAll((key, value) => key == index ? Colors.grey : Colors.white);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.width * 0.37,
                child: const Text(
                  "Pick your preferred brand",
                  style: TextStyle(
                    fontSize: 37,
                    fontFamily: "Arvo-Bold",
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildLogoButton("images/ford-logo.png", 1),
                      buildLogoButton("images/bmw-logo.png", 2),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildLogoButton("images/tesla-logo.png", 3),
                    buildLogoButton("images/mercedes-logo.png", 4),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/carList");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  foregroundColor: Colors.white,
                  fixedSize: const Size(215, 46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Rent a car',
                  style: TextStyle(fontFamily: "Arvo-Regular", fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLogoButton(String imagePath, int index) {
    return InkWell(
      onTap: () {
        changeColor(index);
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(color: buttonColors[index]),
        child: Image(
          image: AssetImage(imagePath),
        ),
      ),
    );
  }
}
