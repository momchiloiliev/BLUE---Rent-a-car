import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/add_pickup_address_screen.dart';
import 'package:flutter_app/ui/brand_pick_screen.dart';
import 'package:flutter_app/ui/home_screen.dart';
import 'package:flutter_app/ui/list_cars_screen.dart';
import 'package:flutter_app/ui/order_confirmed_screen.dart';
import 'package:flutter_app/ui/payment_option_screen.dart';
import 'package:flutter_app/ui/payment_screen.dart';
import 'package:flutter_app/ui/rent_selection_screen.dart';
import 'package:flutter_app/ui/your_reservations_screen.dart';
import 'package:flutter_app/ui/your_selection_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Set your MaterialApp properties here
      home: const HomeScreen(),
      routes: {
        "/pickBrand": (context) => const BrandPickScreen(),
        "/carList": (context) {
          return const ListCarsScreen();
        },
        "/rentSelection": (context) {
          return const RentSelectionScreen();
        },
        "/addPickUpAddress": (context) => const AddPickUpAddressScreen(),
        "/yourSelection": (context) => const YourSelectionScreen(),
        "/paymentOption": (context) => const PaymentOptionScreen(),
        "/payment": (context) => const PaymentScreen(),
        "/orderConfirmed": (context) => const OrderConfirmedScreen(),
        "/yourReservations": (context) => const YourReservationsScreen(),
      },
    );
  }
}
