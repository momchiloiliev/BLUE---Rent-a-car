import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../model/car.dart';
import '../model/reservation.dart';
import '../ui/appbar.dart';
import '../ui/shadow_button.dart';
import 'dart:io';

class AddPickUpAddressScreen extends StatefulWidget {
  const AddPickUpAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddPickUpAddressScreen> createState() => _AddPickUpAddressScreenState();
}

class _AddPickUpAddressScreenState extends State<AddPickUpAddressScreen> {
  final _formKey = GlobalKey<FormState>();
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

  late File? _imageFile = null;

  Widget textField(
      String label,
      TextEditingController controller,
      String? Function(String?)? validator, {
        VoidCallback? onTapIcon,
      }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        suffixIcon: (label == "Pick Up Address" || label == "Return Address")
            ? IconButton(
          icon: Icon(Icons.location_on),
          onPressed: onTapIcon,
        )
            : null,
      ),
      validator: validator,
      onChanged: (value) {
        controller.text = value;
      },
    );
  }

  void _updateLocationController(TextEditingController controller, PlaceLocation location) {
    setState(() {
      controller.text = location.address ?? "Address not available";
    });
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _imageFile != null
                    ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue,
                      width: 5.0, // Adjust the width as needed
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 70,
                    backgroundImage: FileImage(
                      File(_imageFile!.path),
                    ),
                  ),
                )
                    : InkWell(
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    final XFile? image = await _picker.pickImage(
                      source: ImageSource.camera,
                    );

                    if (image != null) {
                      setState(() {
                        _imageFile = File(image.path);
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 30,
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _imageFile != null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    final XFile? image =
                    await _picker.pickImage(source: ImageSource.camera);

                    if (image != null) {
                      setState(() {
                        _imageFile = File(image.path);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: Text(
                    "Edit photo",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textField(
                        "Name",
                        _nameController,
                            (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      textField(
                        "Email",
                        _emailController,
                            (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      textField(
                        "Phone",
                        _phoneController,
                            (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          return null;
                        },
                      ),
                      textField(
                        "Pick Up Address",
                        _pickUpAddressController,
                            (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter pickup location';
                          }
                          return null;
                        },
                        onTapIcon: () async {
                          PlaceLocation? selectedLocation = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreen(
                                isSelecting: true,
                                onSelectLocation: (PlaceLocation location) {
                                  _updateLocationController(_pickUpAddressController, location);
                                },
                              ),
                            ),
                          );

                          if (selectedLocation != null) {
                            _updateLocationController(_pickUpAddressController, selectedLocation);
                          }
                        },
                      ),
                      textField(
                        "Return Address",
                        _returnAddressController,
                            (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter return location';
                          }
                          return null;
                        },
                        onTapIcon: () async {
                          PlaceLocation? selectedLocation = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreen(
                                isSelecting: true,
                                onSelectLocation: (PlaceLocation location) {
                                  _updateLocationController(_returnAddressController, location);
                                },
                              ),
                            ),
                          );

                          if (selectedLocation != null) {
                            _updateLocationController(_returnAddressController, selectedLocation);
                          }
                        },
                      ),
                    ],
                  ),
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
                        if (_formKey.currentState!.validate()) {
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
                        }
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
