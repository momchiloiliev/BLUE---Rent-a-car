import "package:flutter/material.dart";

class ListCarsScreen extends StatefulWidget {
  const ListCarsScreen({super.key});

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [SizedBox(height: 70), brandList(), ellipse()],
      ),
    );
  }

  Widget brandList() {
    return Container(
      height: 90,
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

  Container ellipse() {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 250,
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              topLeft: Radius.elliptical(1000, 800),
              topRight: Radius.elliptical(1000, 800))),
    );
  }
}
