import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/past_reservations_details.dart';
import 'package:flutter_app/ui/reservation_car_details.dart';

class YourReservationsScreen extends StatefulWidget {
  const YourReservationsScreen({Key? key});

  @override
  State<YourReservationsScreen> createState() => _YourReservationsScreenState();
}

class _YourReservationsScreenState extends State<YourReservationsScreen> {
  late String? userId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      userId = ModalRoute.of(context)?.settings.arguments as String?;
      setState(() {}); // Refresh the UI after userId is set
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Your Reservations',
              style: TextStyle(
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
            bottom: const TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white60,
              tabs: [
                Tab(
                  child: Text(
                    'Active',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Past',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Rest of your Scaffold content
          body: userId != null
              ? FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(userId)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || !snapshot.data!.exists) {
                      return const Center(
                        child: Text('No data found.'),
                      );
                    } else {
                      final List<dynamic> reservationRefs =
                          snapshot.data!.get('reservations') ?? [];

                      return FutureBuilder<
                          List<DocumentSnapshot<Map<String, dynamic>>>>(
                        future: Future.wait(
                          reservationRefs.map((ref) => ref.get()),
                        ),
                        builder: (BuildContext context,
                            AsyncSnapshot<
                                    List<
                                        DocumentSnapshot<Map<String, dynamic>>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text('No reservation data found.'),
                            );
                          } else {
                            final List<DocumentSnapshot<Map<String, dynamic>>>
                                reservationDocs = snapshot.data!;
                            final List<Map<String, dynamic>> reservationsData =
                                reservationDocs
                                    .map((doc) =>
                                        doc.data() as Map<String, dynamic>)
                                    .toList();
                            print(reservationsData.length);

                            final List<Map<String, dynamic>>
                                activeReservations =
                                getActiveReservations(reservationsData);
                            final List<Map<String, dynamic>> pastReservations =
                                getPastReservations(reservationsData);

                            return TabBarView(
                              children: [
                                // Active Reservations Tab
                                ListView.builder(
                                  itemCount: activeReservations.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return buildCarDetailsContainer(
                                      context,
                                      activeReservations[index],
                                      "Cancel Reservation",
                                    );
                                  },
                                ),

                                // Past Reservations Tab
                                ListView.builder(
                                  itemCount: pastReservations.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return buildCarDetailsContainerPast(
                                        context, pastReservations[index]);
                                  },
                                ),
                              ],
                            );
                          }
                        },
                      );
                    }
                  },
                )
              : const Center(
                  child: Text('User ID not found.'),
                ),
        ));
  }

  List<Map<String, dynamic>> getActiveReservations(
      List<Map<String, dynamic>> reservations) {
    final DateTime now = DateTime.now();
    return reservations.where((reservation) {
      final DateTime reserveDate = reservation['reserveDate'].toDate();
      final DateTime returnDate = reservation['returnDate'].toDate();
      return reserveDate.isBefore(now) && returnDate.isAfter(now);
    }).toList();
  }

  List<Map<String, dynamic>> getPastReservations(
      List<Map<String, dynamic>> reservations) {
    final DateTime now = DateTime.now();
    return reservations.where((reservation) {
      final DateTime reserveDate = reservation['reserveDate'].toDate();
      final DateTime returnDate = reservation['returnDate'].toDate();
      return returnDate.isBefore(now);
    }).toList();
  }
}
