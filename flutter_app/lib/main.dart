import 'package:flutter/material.dart';
import 'package:flutter_app/ui/brand_pick_screen.dart';
import 'package:flutter_app/ui/home_screen.dart';
import 'package:flutter_app/ui/list_cars_screen.dart';
import 'package:flutter_app/ui/rent_selection_screen.dart';

void main() {
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
        "/carList": (context) => const ListCarsScreen(),
        "/rentSelection": (context) => const RentSelectionScreen(),
      },
    );
  }
}