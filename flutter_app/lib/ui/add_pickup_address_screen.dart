import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/ui/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../model/car.dart';
import '../model/reservation.dart';
import '../ui/appbar.dart';

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
  late Future<DocumentSnapshot<Object?>> user =
      getUserDocument(reservation.user);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pickUpAddressController =
      TextEditingController();
  final TextEditingController _returnAddressController =
      TextEditingController();

  late File? _imageFile = null;

  PlaceLocation? _selectedLocation;

  Widget textField(
    String label,
    TextEditingController controller,
    String? Function(String?)? validator, {
    VoidCallback? onTapIcon,
  }) {
    TextInputType keyboardType = TextInputType.text;
    List<TextInputFormatter>? inputFormatters;

    if (label == "Phone") {
      keyboardType = TextInputType.phone;
      inputFormatters = [FilteringTextInputFormatter.digitsOnly];
    }

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
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }

  Future<void> _updateLocationController(
      TextEditingController controller, PlaceLocation location) async {
    setState(() {
      controller.text = location.address ?? "Address not available";
    });
  }

  Future<void> updateUserDocument(DocumentSnapshot userDoc) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userDoc.id)
          .update({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
      });
    } catch (e) {
      print('Error updating user document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Object?>>(
      future: user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text('No user data available.');
        } else {
          DocumentSnapshot<Object?> userData = snapshot.data!;
          if (!_nameController.text.isEmpty &&
              !_emailController.text.isEmpty &&
              !_phoneController.text.isEmpty) {
            _nameController.text = _nameController.text;
            _emailController.text = _emailController.text;
            _phoneController.text = _phoneController.text;
          }

          if (userData.exists) {
            print("Name: " + _nameController.text);
            print("Email: " + _emailController.text);
            print("Phone: " + _phoneController.text);
            _nameController.text = _nameController.text.isEmpty
                ? userData['name']
                : _nameController.text;
            _emailController.text = _emailController.text.isEmpty
                ? userData['email']
                : _emailController.text;
            _phoneController.text = _phoneController.text.isEmpty
                ? userData['phone']
                : _phoneController.text;
          }

          return Scaffold(
            appBar: const CustomAppBar(
              title: "Add Pick Up Address",
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Camera and image related widgets
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CameraImageWidget(
                        imageFile: _imageFile,
                        onImageCapture: (File imageFile) {
                          setState(() {
                            _imageFile = imageFile;
                          });
                        },
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
                          final XFile? image = await _picker.pickImage(
                            source: ImageSource.camera,
                          );

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
                // Input form related widgets
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
                                PlaceLocation? selectedLocation =
                                    await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapScreen(
                                      isSelecting: true,
                                      onSelectLocation:
                                          (PlaceLocation location) {
                                        print(
                                            'Selected Location: ${location.address}');
                                        _updateLocationController(
                                            _pickUpAddressController, location);
                                        setState(() {
                                          _selectedLocation = location;
                                        });
                                        Navigator.pop(context, location);
                                      },
                                    ),
                                  ),
                                );
                                if (selectedLocation != null) {
                                  // Handle the selected location as needed
                                  _updateLocationController(
                                      _pickUpAddressController,
                                      selectedLocation);
                                  setState(() {
                                    _selectedLocation = _selectedLocation;
                                  });
                                  print('Selected Location: $selectedLocation');
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
                                PlaceLocation? selectedLocation =
                                    await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapScreen(
                                      isSelecting: true,
                                      onSelectLocation:
                                          (PlaceLocation location) {
                                        print(
                                            'Selected Location: ${location.address}');
                                        _updateLocationController(
                                            _returnAddressController, location);
                                        setState(() {
                                          _selectedLocation = location;
                                        });
                                        Navigator.pop(context, location);
                                      },
                                    ),
                                  ),
                                );
                                if (selectedLocation != null) {
                                  // Handle the selected location as needed
                                  print('Selected Location: $selectedLocation');
                                  _updateLocationController(
                                      _returnAddressController,
                                      selectedLocation);
                                  setState(() {
                                    _selectedLocation = _selectedLocation;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Save button
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
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate()) {
                                updateUserDocument(userData);
                                reservation.pickupLocation =
                                    _pickUpAddressController.text;
                                reservation.returnLocation =
                                    _returnAddressController.text;
                                print(reservation);

                                // Instead of directly navigating, return the reservation object
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
      },
    );
  }
}

class CameraImageWidget extends StatefulWidget {
  final File? imageFile;
  final Function(File) onImageCapture;

  const CameraImageWidget({
    Key? key,
    required this.imageFile,
    required this.onImageCapture,
  }) : super(key: key);

  @override
  _CameraImageWidgetState createState() => _CameraImageWidgetState();
}

class _CameraImageWidgetState extends State<CameraImageWidget> {
  late File? _imageFile;

  @override
  void initState() {
    super.initState();
    _imageFile = widget.imageFile;
  }

  @override
  void didUpdateWidget(covariant CameraImageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageFile != oldWidget.imageFile) {
      setState(() {
        _imageFile = widget.imageFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _imageFile != null
        ? Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue,
                width: 5.0,
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
              final XFile? image =
                  await _picker.pickImage(source: ImageSource.camera);

              if (image != null) {
                widget.onImageCapture(File(image.path));
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
          );
  }
}
