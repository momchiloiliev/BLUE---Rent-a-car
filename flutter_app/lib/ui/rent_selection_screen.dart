import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/deviceUtils.dart';
import 'package:flutter_app/model/reservation.dart';

import '../model/car.dart';

class RentSelectionScreen extends StatefulWidget {
  const RentSelectionScreen({Key? key}) : super(key: key);

  @override
  State<RentSelectionScreen> createState() {
    return _RentSelectionScreenState();
  }
}

class _RentSelectionScreenState extends State<RentSelectionScreen> {
  late Car car;
  DateTime? selectedDate = DateTime.now();
  String startingFromDateInfo = "Today";
  late int carPrice;
  int dayCount = 1;
  bool isDriverSelected = false;
  bool isBabySeatSelected = false;
  int driverIncludedPrice = 3000;
  int babySeatIncludedPrice = 1000;
  late int checkoutSum;
  Future<String?>? userIdFuture;
  List<DateTime> reservedDates = [];

  bool isCarInitialized() {
    return car != null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access inherited widgets or perform operations here
    // Example: accessing theme
    final theme = Theme.of(context);
    // Perform operations with the theme or other inherited widgets
    userIdFuture = DeviceUtils.getDeviceId(theme);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      car = ModalRoute.of(context)!.settings.arguments as Car;
      // setState to trigger a rebuild after initialization
      setState(() {
        checkoutSum = car.price * 50;
      });
    });
  }

  bool isDateSelectable(DateTime date) {
    // Check if the date is not contained in reservedDates or is today
    return !reservedDates.contains(date) || isToday(date);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final List<DateTime> fetchedReservedDates =
        await fetchReservedDates(car.id);

    print(fetchedReservedDates);

    // Logic to find the first available date after today
    DateTime? firstAvailableDate;
    for (DateTime date = now;
        date.isBefore(DateTime(2101));
        date = date.add(Duration(days: 1))) {
      if (!fetchedReservedDates.contains(date)) {
        firstAvailableDate = date;
        break;
      }
    }

    setState(() {
      reservedDates = fetchedReservedDates;
    });

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(2101),
      selectableDayPredicate: (DateTime date) {
        // Check if the date is selectable based on your criteria
        return isDateSelectable(date);
      },
    );

    if (picked != null && isDateSelectable(picked)) {
      setState(() {
        selectedDate = picked;

        // Update the text based on the selected date
        if (isToday(picked)) {
          startingFromDateInfo = "Today";
        } else if (isTomorrow(picked)) {
          startingFromDateInfo = "Tomorrow";
        } else {
          startingFromDateInfo = " ";
        }
      });
    } else {
      setState(() {
        startingFromDateInfo = " ";
      });
    }
  }

  bool isToday(DateTime date) {
    final today = DateTime.now();
    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }

  bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  void _addDay() {
    setState(() {
      dayCount++;
      _calculateCheckoutSum();
    });
  }

  void _removeDay() {
    if (dayCount > 1) {
      setState(() {
        dayCount--;
        _calculateCheckoutSum();
      });
    }
  }

  void _calculateCheckoutSum() async {
    setState(() {
      int daysTotal = car.price * 50 * dayCount;
      int driverTotal = isDriverSelected ? driverIncludedPrice * dayCount : 0;
      int babySeatTotal = isBabySeatSelected ? babySeatIncludedPrice : 0;
      checkoutSum = daysTotal + driverTotal + babySeatTotal;
    });
  }

  // void _fetchUserId() {
  //   DeviceUtils.getDeviceId(context).then((value) {
  //     setState(() {
  //       userId = value!;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (!isCarInitialized()) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.blueAccent,
          automaticallyImplyLeading: false,
        ),
      ),
      body: FutureBuilder<String?>(
          future: userIdFuture,
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                child: Text('Error fetching user ID: ${snapshot.error}'),
              );
            } else {
              String? userId = snapshot.data;

              if (userId != null) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 57.0, top: 40.0),
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.blue,
                                        size: 34.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 60.0, top: 28.0),
                              child: Container(
                                width: 350,
                                height: 580,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE5E9F2),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    bottomLeft: Radius.circular(25.0),
                                  ),
                                ),
                                child: Column(children: [
                                  const Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 35.0, top: 50.0),
                                              child: Icon(
                                                Icons.water_drop,
                                                color: Colors.blueAccent,
                                                size: 25.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 35.0, top: 40.0),
                                            child: Text(
                                              car.model,
                                              style: const TextStyle(
                                                fontSize: 30.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0, left: 30.0),
                                        child: Container(
                                          width: 295.0,
                                          height: 70.0,
                                          child: ElevatedButton(
                                            onPressed: () =>
                                                _selectDate(context),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: const BorderSide(
                                                  color: Colors.grey,
                                                  width: 2.0,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  selectedDate != null
                                                      ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                                      : "Starting from",
                                                  style: const TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black38,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    startingFromDateInfo,
                                                    style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 2.0),
                                                  child: Icon(
                                                    Icons.calendar_month,
                                                    color: Colors.black,
                                                    size: 30.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30.0, top: 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Days",
                                                style: TextStyle(
                                                  fontSize: 28.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${car.price * 50}",
                                                    style: const TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                  const Text(
                                                    " MKD/day",
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12.0, top: 20.0),
                                          child: Container(
                                            width: 155,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                color: Colors.grey,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10.0)),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                  onPressed: _removeDay,
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    color: Colors.black38,
                                                    size: 30.0,
                                                  ),
                                                ),
                                                Text(
                                                  dayCount.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 30.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: _addDay,
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: Colors.black38,
                                                    size: 30.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, top: 10.0),
                                            child: Checkbox(
                                              value: isDriverSelected,
                                              activeColor: Colors.blueAccent,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  isDriverSelected =
                                                      value ?? false;
                                                  _calculateCheckoutSum();
                                                });
                                              },
                                              visualDensity:
                                                  VisualDensity.comfortable,
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Driver',
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black38,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, right: 30.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              driverIncludedPrice.toString(),
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const Text(
                                              " MKD/day",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Checkbox(
                                              value: isBabySeatSelected,
                                              activeColor: Colors.blueAccent,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  isBabySeatSelected =
                                                      value ?? false;
                                                  _calculateCheckoutSum();
                                                });
                                              },
                                              visualDensity:
                                                  VisualDensity.comfortable,
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 1),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Baby Seat',
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black38,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 2.0, right: 30.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              babySeatIncludedPrice.toString(),
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const Text(
                                              " MKD",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 40.0),
                                        child: Container(
                                          width: 250,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              // Check if the user already exists in the 'users' collection
                                              QuerySnapshot<
                                                      Map<String, dynamic>>
                                                  userSnapshot =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('users')
                                                      .where('userId',
                                                          isEqualTo:
                                                              userId!) // Replace 'userId' with your actual field name
                                                      .get();

                                              DocumentReference? userRef;
                                              if (userSnapshot
                                                  .docs.isNotEmpty) {
                                                userRef = userSnapshot
                                                    .docs[0].reference;
                                              } else {
                                                // If the user doesn't exist, add the user to the 'users' collection
                                                DocumentReference newUserRef =
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .add({
                                                  'userId':
                                                      userId, // Include userId in the user document
                                                  // Include other user details here
                                                });
                                                userRef = newUserRef;
                                              }

                                              Reservation reservation =
                                                  Reservation(
                                                userRef.id,
                                                car.id,
                                                dayCount,
                                                isDriverSelected,
                                                isBabySeatSelected,
                                                checkoutSum,
                                                selectedDate ?? DateTime.now(),
                                                selectedDate!.add(
                                                    Duration(days: dayCount)),
                                                "", // Replace these empty strings with actual values
                                                "", // Replace these empty strings with actual values
                                                "", // Replace these empty strings with actual values
                                                "", // Replace these empty strings with actual values
                                                "",
                                              );

                                              Navigator.pushNamed(
                                                  context, "/addPickUpAddress",
                                                  arguments: [
                                                    car,
                                                    reservation
                                                  ]);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.grey,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: const BorderSide(
                                                  color: Colors.grey,
                                                  width: 3.0,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Checkout - $checkoutSum MKD",
                                                  style: const TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black38,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      left: 170.0,
                      top: 1.0,
                      child: Image.network(
                        car.imageLink,
                        width: 300.0,
                        height: 300.0,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ); // Build UI content with userId
              }
            }
            return Text("Errror");
          }),
    );
  }
}
