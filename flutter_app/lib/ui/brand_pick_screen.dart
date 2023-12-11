import 'package:flutter/material.dart';

class BrandPickScreen extends StatefulWidget {
  const BrandPickScreen({Key? key}) : super(key: key);

  @override
  _BrandPickScreenState createState() => _BrandPickScreenState();
}

class _BrandPickScreenState extends State<BrandPickScreen> {
  late String brand = "Ford";
  bool isSelected = false;

  Map<String, String> brandLogos = {
    "Ford": "images/ford-logo.png",
    "BMW": "images/bmw-logo.png",
    "Tesla": "images/tesla-logo.png",
    "Mercedes": "images/mercedes-logo.png",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.width * 0.37,
                    child: const Text(
                      "Pick your preferred brand",
                      style: TextStyle(
                        fontSize: 38,
                        fontFamily: "Arvo-Bold",
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildLogoButton("images/ford-logo.png", "Ford"),
                buildLogoButton("images/bmw-logo.png", "BMW"),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildLogoButton("images/tesla-logo.png", "Tesla"),
                buildLogoButton("images/mercedes-logo.png", "Mercedes"),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top:38.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/carList", arguments: brand);
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
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLogoButton(String imagePath, String pickedBrand) {
    return InkWell(
      onTap: () {
        setState(() {
          brand = pickedBrand;
          isSelected = true;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: brand == pickedBrand ? Colors.lightBlue : Colors.transparent,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: isSelected ? 80 : 80,
              height: isSelected ? 80 : 80,
              child: Image(
                image: AssetImage(imagePath),
                fit: BoxFit.contain,
              ),
            ),
            if (brand == pickedBrand && isSelected)
              Image.asset(
                "images/check-mark.png",
                width: 22,
                height: 22,
                color: Colors.blue,
              ),
          ],
        ),
      ),
    );
  }
}
