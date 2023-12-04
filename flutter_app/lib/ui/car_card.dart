import "package:flutter/material.dart";

class CarCard extends StatefulWidget {
  const CarCard({super.key});

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            child: Transform.translate(
              offset: const Offset(10, -20),
              child: const Image(
                width: 100,
                height: 40,
                image: AssetImage("images/mercedes.png"),
              ),
            ),
          ),
          Row(
            children: [
              Column(
                children: [Text("cscs"), Text("cscsv")],
              ),
              Column()
            ],
          ),
          Row(
            children: [Column()],
          ),
          Row(
            children: [
              Column(
                children: [],
              ),
              Column()
            ],
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
