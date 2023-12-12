import 'package:flutter/material.dart';
import 'package:flutter_app/model/car.dart';
import 'package:flutter_app/ui/appbar.dart';
import 'package:flutter_app/ui/shadow_button.dart';

import '../model/reservation.dart';

class AddPickUpAddressScreen extends StatefulWidget {
  const AddPickUpAddressScreen({super.key});

  @override
  State<AddPickUpAddressScreen> createState() => _AddPickUpAddressScreenState();
}

class _AddPickUpAddressScreenState extends State<AddPickUpAddressScreen> {
  late List<dynamic> arguments =
      ModalRoute.of(context)!.settings.arguments as List<dynamic>? ?? [];
  late Car car = arguments[0] as Car;
  late Reservation reservation = arguments[1] as Reservation;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pickUpAddressController =
      TextEditingController();
  final TextEditingController _returnAddressController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Set initial text values if available
    _nameController.text = reservation.name;
    _emailController.text = reservation.email;
    _phoneController.text = reservation.phone;
    _pickUpAddressController.text = reservation.pickupLocation;
    _returnAddressController.text = reservation.returnLocation;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Add Pick Up Address",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.gps_fixed,
                    color: Colors.blue,
                    size: 25,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "Use current location",
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textField("Name", _nameController),
                    textField("Email", _emailController),
                    textField("Phone", _phoneController),
                    textField("Pick Up Address", _pickUpAddressController),
                    textField("Return Address", _returnAddressController),
                  ],
                ),
              ),
            ),
          ),
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
                        reservation.name = _nameController.text;
                        reservation.email = _emailController.text;
                        reservation.phone = _phoneController.text;
                        reservation.pickupLocation =
                            _pickUpAddressController.text;
                        reservation.returnLocation =
                            _returnAddressController.text;
                        print(reservation);
                        Navigator.pushNamed(context, "/yourSelection",
                            arguments: [car, reservation]);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        "Save",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget textField(String label, TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
        labelText: label, labelStyle: const TextStyle(color: Colors.grey)),
    onChanged: (value) {
      controller.text = value;
    },
  );
}
