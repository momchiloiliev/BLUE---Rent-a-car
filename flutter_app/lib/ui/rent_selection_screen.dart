import 'package:flutter/material.dart';

class RentSelectionScreen extends StatefulWidget {
  const RentSelectionScreen({Key? key}) : super(key: key);

  @override
  State<RentSelectionScreen> createState() {
    return _RentSelectionScreenState();
  }
}

class _RentSelectionScreenState extends State<RentSelectionScreen> {
  DateTime? selectedDate;
  String startingFromDateInfo = "";
  int dayCount = 0;
  bool driverSelected = false;
  bool babySitSelected = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now, // Set the first date to be the current date
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;

        // Update the text based on the selected date
        if (isToday(picked)) {
          startingFromDateInfo = "Today";
        } else if (isTomorrow(picked)) {
          startingFromDateInfo = "Tomorrow";
        } else {
          startingFromDateInfo = "";
        }
      });
    } else {
      // No date chosen
      setState(() {
        startingFromDateInfo = "";
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
    });
  }

  void _removeDay() {
    if (dayCount > 0) {
      setState(() {
        dayCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.blueAccent,
          automaticallyImplyLeading: false,
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 115.0, bottom: 42.0),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      bottomLeft: Radius.circular(16.0),
                    ),
                    child: Container(
                      color: const Color(0xFFE5E9F2),
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 200.0,
            left: 75.0,
            child: Icon(
              Icons.water_drop,
              color: Colors.blueAccent,
              size: 25.0,
            ),
          ),
          const Positioned(
            top: 295.0,
            left: 80.0,
            right: 50.0,
            child: Text(
              "Edge ST",
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const Positioned(
            left: 110.0,
            top: 1.0,
            child: Image(
              image: AssetImage("images/ford.png"),
              width: 380.0,
              height: 350.0,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            width: 300.0,
            height: 60.0,
            top: 360.0,
            left: 80.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: const EdgeInsets.all(16.0),
            ),
          ),
          Positioned(
            top: 375.0,
            left: 330.0,
            child: GestureDetector(
              onTap: () => _selectDate(context),
              child: const Icon(
                Icons.calendar_month,
                color: Colors.black,
                size: 30.0,
              ),
            ),
          ),
          Positioned(
            top: 378.0,
            left: 230.0,
            child: Text(
              startingFromDateInfo,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: 382.0,
            left: 100.0,
            child: Text(
              selectedDate != null
                  ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                  : "Starting from",
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: Colors.black38,
              ),
            ),
          ),
          const Positioned(
            top: 430.0,
            left: 80.0,
            right: 50.0,
            child: Text(
              "Days",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
          const Positioned(
            top: 465.0,
            left: 80.0,
            right: 50.0,
            child: Text(
              "3.000",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.black38,
              ),
            ),
          ),
          const Positioned(
            top: 465.0,
            left: 128.0,
            right: 50.0,
            child: Text(
              "MKD/day",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.black38,
              ),
            ),
          ),
          Positioned(
            width: 130.0,
            height: 60.0,
            top: 430.0,
            left: 250.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: const EdgeInsets.all(16.0),
            ),
          ),
          Positioned(
            top: 430.0,
            left: 250.0,
            child: IconButton(
                onPressed: _removeDay,
                icon: const Icon(
                  Icons.remove,
                  color: Colors.black38,
                  size: 40.0,
                )),
          ),
          Positioned(
            top: 438.0,
            left: 305.0,
            child: Text(
              dayCount.toString(),
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: 430.0,
            left: 325.0,
            child: IconButton(
              onPressed: _addDay,
              icon: const Icon(
                Icons.add,
                color: Colors.black38,
                size: 40.0,
              ),
            ),
          ),
          const Positioned(
            top: 500.0,
            left: 78.0,
            child: Icon(
              Icons.crop_square_sharp,
              color: Colors.black,
              size: 30.0,
            ),
          ),
          const Positioned(
            top: 530.0,
            left: 78.0,
            child: Icon(
              Icons.crop_square_sharp,
              color: Colors.black,
              size: 30.0,
            ),
          ),
          const Positioned(
              top: 502.0,
              left: 110.0,
              child: Text(
                "Driver",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                ),
              )),
          const Positioned(
              top: 532.0,
              left: 110.0,
              child: Text(
                "Baby sit",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                ),
              )),
          const Positioned(
            top: 502.0,
            right: 120.0,
            child: Text(
              "7.000",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.black38,
              ),
            ),
          ),
          const Positioned(
            top: 502.0,
            right: 35.0,
            child: Text(
              "MKD/day",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.black38,
              ),
            ),
          ),
          const Positioned(
            top: 532.0,
            right: 120.0,
            child: Text(
              "1.000",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.black38,
              ),
            ),
          ),
          const Positioned(
            top: 532.0,
            right: 72.0,
            child: Text(
              "MKD",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.black38,
              ),
            ),
          ),
          Positioned(
            width: 300.0,
            height: 60.0,
            top: 600.0,
            left: 80.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: const EdgeInsets.all(16.0),
            ),
          ),
          Positioned(
            top: 615.0,
            left: 130.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/addPickUpAddress");
              },
              child: Text(
                "Checkout - ",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 615.0,
            left: 230.0,
            child: Text(
              "3.000",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          const Positioned(
            top: 615.0,
            left: 285.0,
            child: Text(
              "MKD",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 15.0,
            left: 42.0,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.white, size: 36.0),
            ),
          ),
        ],
      ),
    );
  }
}
