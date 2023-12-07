import 'package:flutter/material.dart';
import 'package:flutter_app/ui/car_card.dart';

class ListCarsScreen extends StatefulWidget {
  const ListCarsScreen({Key? key}) : super(key: key);

  @override
  State<ListCarsScreen> createState() => _ListCarsScreenState();
}

class _ListCarsScreenState extends State<ListCarsScreen> {
  List<String> images = [
    "images/bmw-logo.png",
    "images/tesla-logo.png",
    "images/ford-logo.png",
    "images/mercedes-logo.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 100,
            child: _buildBrandList(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildEllipse(),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 230,
            child: Column(
              children: [
                _buildCarList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandList() {
    return Container(
      height: 80,
      child: ListView.separated(
        itemCount: images.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(
          width: 50,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Implement action on image tap
            },
            child: Image(
              image: AssetImage(images[index]),
              width: 100,
            ),
          );
        },
      ),
    );
  }

  Container _buildEllipse() {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(1000, 800),
          topRight: Radius.elliptical(1000, 800),
        ),
      ),
    );
  }

  Widget _buildCarList() {
    return Container(
      height: 580,
      child: ListView.separated(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        // physics: PageScrollPhysics(),
        separatorBuilder: (context, index) => SizedBox(
          width: 10,
        ),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              margin: EdgeInsets.only(left: 23.0),
              child: CarCard(),
            );
          } else
            return CarCard();
          // return CarCard();
        },
      ),
    );
  }
}
