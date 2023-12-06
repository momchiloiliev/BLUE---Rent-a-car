import "package:flutter/material.dart";

class CarCard extends StatefulWidget {
  const CarCard({super.key});

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Transform.translate(
            offset: const Offset(30, -30),
            child: const Image(
              width: 300,
              height: 200,
              image: AssetImage("images/bmw_amg.png"),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BMW GLA45",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontFamily: "Avro-Bold",
                    ),
                  ),
                  Text(
                    "3000MKD/day",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontFamily: "Avro",
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 50,
              ),
              Column(
                children: [
                  Icon(
                    Icons.water_drop,
                    color: Colors.blue,
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 220,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.local_gas_station,
                          size: 23,
                          color: Colors.white,
                        ),
                        Text(
                          '531 KM',
                          style: TextStyle(
                              fontFamily: "Avro",
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        Text(
                          'on full tank',
                          style: TextStyle(
                              fontFamily: "Avro",
                              fontSize: 10,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.,
            children: [
              Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 6.0, top: 4.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.air_sharp,
                                size: 23,
                                color: Colors.blueAccent,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Row(
                            children: [
                              Text(
                                '5.6 sec',
                                style: TextStyle(
                                    fontFamily: "Avro",
                                    fontSize: 19,
                                    color: Colors.blueAccent),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Row(
                            children: [
                              Text(
                                '0-100 KM/h',
                                style: TextStyle(
                                    fontFamily: "Avro",
                                    fontSize: 11,
                                    color: Colors.blueAccent),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 65,
              ),
              Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 6.0, top: 4.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.wind_power_outlined,
                                size: 23,
                                color: Colors.blueAccent,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Row(
                            children: [
                              Text(
                                '416 HP',
                                style: TextStyle(
                                    fontFamily: "Avro",
                                    fontSize: 19,
                                    color: Colors.blueAccent),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Row(
                            children: [
                              Text(
                                'Power',
                                style: TextStyle(
                                    fontFamily: "Avro",
                                    fontSize: 11,
                                    color: Colors.blueAccent),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/rentSelection");
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  foregroundColor: Colors.white,
                  fixedSize: const Size(215, 46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              child: const Text(
                'Rent BMW GLA45',
                style: TextStyle(fontFamily: "Arvo-Regular", fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}