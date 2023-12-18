import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/deviceUtils.dart';
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

  late Stream<QuerySnapshot<Map<String, dynamic>>> firestoreDb;
  late String brand = ModalRoute.of(context)!.settings.arguments.toString();

  @override
  void initState() {
    super.initState();
    firestoreDb = FirebaseFirestore.instance.collection("cars").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: DeviceUtils.getDeviceId(Theme.of(context)),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              // Display a placeholder AppBar while the userId is being fetched
              title: Text('Cars',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.blue,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Center(
              // Display a loading indicator or message while fetching the userId
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // Handle error case
          return Scaffold(
            appBar: AppBar(
              title: Text('Error',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.red, // Change color to indicate error
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Center(
              // Display an error message or an alternative UI for error state
              child: Text('Error fetching userId'),
            ),
          );
        } else {
          final userId = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Cars",
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
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.library_books_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    // Navigate to another screen when this button is clicked
                    if (userId != null) {
                      QuerySnapshot<
                          Map<String,
                              dynamic>> userSnapshot = await FirebaseFirestore
                          .instance
                          .collection('users')
                          .where('userId',
                              isEqualTo:
                                  userId!) // Replace 'userId' with your actual field name
                          .get();

                      DocumentReference? userRef;
                      if (userSnapshot.docs.isNotEmpty) {
                        userRef = userSnapshot.docs[0].reference;
                      } else {
                        // If the user doesn't exist, add the user to the 'users' collection
                        DocumentReference newUserRef = await FirebaseFirestore
                            .instance
                            .collection('users')
                            .add({
                          'userId':
                              userId, // Include userId in the user document
                          // Include other user details here
                          'reservations': [],
                          'name': "",
                          'email': "",
                          "phone": ""
                        });
                        userRef = newUserRef;
                      }
                      Navigator.pushNamed(
                        context,
                        "/yourReservations",
                        arguments: userRef.id,
                      );
                    }
                  },
                ),
              ],
            ),
            body: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 20,
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
                  top: 150,
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
      },
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
              setState(() {
                switch (index) {
                  case 0:
                    brand = "BMW";
                    break;
                  case 1:
                    brand = "Tesla";
                    break;
                  case 2:
                    brand = "Ford";
                    break;
                  case 3:
                    brand = "Mercedes";
                    break;
                }
              });
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
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestoreDb,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No Data');
          } else {
            // Filter cars based on brand
            List<QueryDocumentSnapshot<Map<String, dynamic>>> filteredCars =
                snapshot.data!.docs
                    .where((car) => car['brand'] == brand)
                    .toList();

            if (filteredCars.isEmpty) {
              return Text('No cars found for this brand');
            }

            return ListView.separated(
              itemCount: filteredCars.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                      margin: EdgeInsets.only(left: 23.0),
                      child: CarCard(
                        snapshot: filteredCars[index],
                        index: index,
                        docId: filteredCars[index].id,
                      ));
                } else
                  return CarCard(
                    snapshot: filteredCars[index],
                    index: index,
                    docId: filteredCars[index].id,
                  );
              },
            );
          }
        },
      ),
    );
  }
}
