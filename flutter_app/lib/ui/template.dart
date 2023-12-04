import 'package:flutter/material.dart';

class ListCarsScreen extends StatefulWidget{
  const ListCarsScreen({super.key});

  @override
  State<ListCarsScreen> createState(){
    return _ListCarsState();
  }
}

class _ListCarsState extends State<ListCarsScreen>{
  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: const BoxDecoration(

          ),
          child: const SizedBox(width: 20,),
    );
  }
}