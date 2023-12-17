import "package:flutter/material.dart";
import "package:flutter_app/ui/appbar.dart";
import "package:flutter_app/ui/reservation_car_details.dart";
import "package:flutter_app/ui/shadow_button.dart";
import "../model/car.dart";
import "../model/reservation.dart";
import "address_container.dart";

class YourSelectionScreen extends StatefulWidget {
  const YourSelectionScreen({super.key});

  @override
  State<YourSelectionScreen> createState() => _YourSelectionScreenState();
}

class _YourSelectionScreenState extends State<YourSelectionScreen> {
  late List<dynamic> arguments =
      ModalRoute.of(context)!.settings.arguments as List<dynamic>? ?? [];
  late Car car = arguments[0] as Car;
  late Reservation reservation = arguments[1] as Reservation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Your Selection'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 10,
                  offset: const Offset(0, 3),
                ),
                const BoxShadow(
                  color: Colors.white,
                  blurRadius: 15,
                  spreadRadius: 15,
                  offset: Offset(0, 3),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 50),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Pick Up Address',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${reservation.pickupLocation}', //todo: city,country map from previous screen
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Change',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 5,
                  offset: const Offset(0, 3),
                ),
                const BoxShadow(
                  color: Colors.white,
                  blurRadius: 15,
                  spreadRadius: 5,
                  offset: Offset(0, 3),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 20,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.25,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 8.0, bottom: 8.0, top: 50.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Image.network(
                                car.imageLink,
                                width: 150,
                                height: 80,
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(car.model,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54)),
                              Text(
                                "${car.price * 50}/per day",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87),
                              ),
                              Row(
                                children: [
                                  Text("Days: ${reservation.days}",
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),

                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Container(
                //   margin: const EdgeInsets.only(top: 20),
                //   decoration: const BoxDecoration(
                //       border: Border(
                //           top: BorderSide(color: Colors.grey, width: 0.2))),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       TextButton(
                //         onPressed: () {},
                //         child: Text("Remove",
                //             style: TextStyle(color: Colors.grey, fontSize: 16)),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          _buildPriceDetailsContainer(),
          Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 15,
                  offset: const Offset(0, 3),
                ),
                const BoxShadow(
                  color: Colors.white,
                  blurRadius: 15,
                  spreadRadius: 4,
                  offset: Offset(0, 3),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 15,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/paymentOption",
                            arguments: reservation);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        "Continue To Payment",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
          // shadowButton("Continue To Payment", "/paymentOption"),
        ],
      ),
    );
  }

  Widget _buildPriceDetailsContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 40),
      padding: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 15,
            offset: const Offset(0, 3),
          ),
          const BoxShadow(
            color: Colors.white,
            blurRadius: 15,
            spreadRadius: 5,
            offset: Offset(0, 3),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price for rental',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                Text('Driver',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                Text('Baby Seat',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                Text('Total',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${car.price * 50 * reservation.days} MKD',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                Text(
                    reservation.driver == true
                        ? "${3000 * reservation.days} MKD"
                        : "0 MKD",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                Text(reservation.babySeat == true ? "1000 MKD" : "0 MKD",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                Text('${reservation.totalPrice} MKD',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
