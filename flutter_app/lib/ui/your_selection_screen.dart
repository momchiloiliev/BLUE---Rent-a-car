import "package:flutter/material.dart";
import "package:flutter_app/ui/appbar.dart";
import "package:flutter_app/ui/reservation_car_details.dart";
import "package:flutter_app/ui/shadow_button.dart";

import "address_container.dart";

class YourSelectionScreen extends StatefulWidget {
  const YourSelectionScreen({super.key});

  @override
  State<YourSelectionScreen> createState() => _YourSelectionScreenState();
}

class _YourSelectionScreenState extends State<YourSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Your Selection'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildAddressContainer(context, 50),
          buildCarDetailsContainer(context, "Remove"),
          _buildPriceDetailsContainer(),
          shadowButton("Continue To Payment", "/paymentOption"),
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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                Text('Delivery Fee',
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
                Text('3000MKD',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                Text('600MKD',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                Text('3600MKD',
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
