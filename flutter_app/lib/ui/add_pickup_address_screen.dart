import 'package:flutter/material.dart';
import 'package:flutter_app/ui/button.dart';

class AddPickUpAddressScreen extends StatefulWidget {
  const AddPickUpAddressScreen({super.key});

  @override
  State<AddPickUpAddressScreen> createState() => _AddPickUpAddressScreenState();
}

class _AddPickUpAddressScreenState extends State<AddPickUpAddressScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Pick Up Address",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                    textField("Street Address", _addressController),
                    textField("City", _cityController),
                    textField("Zipcode", _zipcodeController),
                  ],
                ),
              ),
            ),
          ),
          const BlueButton(text: "Save", route: "route")
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
