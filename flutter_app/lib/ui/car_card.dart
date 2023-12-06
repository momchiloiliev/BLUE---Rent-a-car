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
      color: Color(0xFFE5E9F2),
      elevation: 15,
      margin: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 330,
            child: Transform.translate(
              offset: const Offset(10, -30),
              child: const Image(
                width: 200,
                height: 180,
                image: AssetImage("images/bmw_amg.png"),
              ),
            ),
          ),
          const Row(
            children: [
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
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
            ],
          ),
          Row(
            children: [
              Container(
                width: 220,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.local_gas_station,
                            size: 23,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: 1,),
                      Row(
                        children: [
                          Text('531 KM', style: TextStyle(fontFamily: "Avro", fontSize: 19, color: Colors.white),),

                        ],
                      ),
                      SizedBox(height: 1,),
                      Row(
                        children: [
                          Text('on full tank', style: TextStyle(fontFamily: "Avro", fontSize: 11, color: Colors.white),),
                        ],
                      ),
                    ],
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
                      color: Color(0xFFE5E9F2),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 6.0,top:4.0),
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
                          SizedBox(height: 1,),
                          Row(
                            children: [
                              Text('5.6 sec', style: TextStyle(fontFamily: "Avro", fontSize: 19, color: Colors.blueAccent),),

                            ],
                          ),
                          SizedBox(height: 1,),
                          Row(
                            children: [
                              Text('0-100 KM/h', style: TextStyle(fontFamily: "Avro", fontSize: 11, color: Colors.blueAccent),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width:65,),
              Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFFE5E9F2),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 6.0,top:4.0),
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
                          SizedBox(height: 1,),
                          Row(
                            children: [
                              Text('416 HP', style: TextStyle(fontFamily: "Avro", fontSize: 19, color: Colors.blueAccent),),

                            ],
                          ),
                          SizedBox(height: 1,),
                          Row(
                            children: [
                              Text('Power', style: TextStyle(fontFamily: "Avro", fontSize: 11, color: Colors.blueAccent),),
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
            padding: const EdgeInsets.only(bottom: 35),
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
                'Rent BMW GLA45',
                style: TextStyle(fontFamily: "Arvo-Regular", fontSize: 17),
              ),
            ),
          )
        ],
      ),
    );
  }
}
