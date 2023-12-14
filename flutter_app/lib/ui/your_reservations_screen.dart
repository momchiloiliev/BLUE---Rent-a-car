import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/address_container.dart';
import 'package:flutter_app/ui/appbar.dart';
import 'package:flutter_app/ui/reservation_car_details.dart';
import 'package:flutter_app/ui/shadow_button.dart';
import 'package:flutter_app/ui/past_reservations_details.dart';

class YourReservationsScreen extends StatefulWidget {
  const YourReservationsScreen({super.key});

  @override
  State<YourReservationsScreen> createState() => _YourReservationsScreenState();
}

class _YourReservationsScreenState extends State<YourReservationsScreen> {
  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Reservations',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
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
          bottom: TabBar(

            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(child: Text('Active', style: TextStyle(fontSize: 17,),),),
              Tab(child: Text('Past', style: TextStyle(fontSize: 17,),),),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder( //todo: da gi dele od baza, sprema data dali e active ili past
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return buildCarDetailsContainer(
                        context,
                        "Cancel Reservation",
                      ); //todo: if status=incoming->cancel reservation=red and clickable, else(ongoing) not clickable grey
                    },
                  ),

                  ListView.builder(
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return buildCarDetailsContainerPast(
                        context,
                      );
                    },
                  ),
                ],
              ),
            ),
            shadowButton("Back to Home", "/carList"),
          ],
        ),
      ),
    );
  }
}
