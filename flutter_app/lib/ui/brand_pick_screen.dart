import "package:flutter/material.dart";

class BrandPickScreen extends StatefulWidget {
  const BrandPickScreen({super.key});

  @override
  State<BrandPickScreen> createState() => _BrandPickScreenState();
}

class _BrandPickScreenState extends State<BrandPickScreen> {

  Map<int, Color> buttonColors = {
    1: Colors.white,
    2: Colors.white,
    3: Colors.white,
    4: Colors.white,
  };

  bool isClicked = true;

  void changeColor(int i) {
    if(isClicked){
      setState(() {
        buttonColors[i] = Colors.grey;
        isClicked = false;
      });
    } else {
      setState(() {
        buttonColors[i] = Colors.white;
        isClicked = true;
      });
    }
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
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.width * 0.37,
                  child: const Text(
                    "Pick your preferred brand",
                    style: TextStyle(
                        fontSize: 40,
                        fontFamily: "Arvo-Bold",
                        color: Colors.lightBlueAccent
                    ),
                  )
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
                      InkWell(
                        onTap: () {
                          changeColor(1);
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: buttonColors[1]
                          ),
                          child: const Image(image: AssetImage(
                              "images/ford-logo.png"
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          changeColor(2);
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              color: buttonColors[2]
                          ),
                          child: const Image(image: AssetImage(
                              "images/bmw-logo.png"
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        changeColor(3);
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: buttonColors[3]
                        ),
                        child: const Image(image: AssetImage(
                            "images/tesla-logo.png"
                        ),fit: BoxFit.cover,),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        changeColor(4);
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: buttonColors[4]
                        ),
                        child: const Image(image: AssetImage(
                            "images/mercedes-logo.png"
                        ), fit: BoxFit.cover,),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, "/" as Route<Object?>);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    foregroundColor: Colors.white,
                    fixedSize: const Size(215, 46),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
                child: const Text(
                  'Rent a car',
                  style: TextStyle(
                      fontFamily: "Arvo-Regular",
                      fontSize: 20
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

