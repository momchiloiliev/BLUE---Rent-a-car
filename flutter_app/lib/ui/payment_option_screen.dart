import 'package:flutter/material.dart';
import 'package:flutter_app/ui/shadow_button.dart';

import 'address_container.dart';
import 'appbar.dart';

class PaymentOptionScreen extends StatefulWidget {
  const PaymentOptionScreen({super.key});



  @override
  State<PaymentOptionScreen> createState() => _PaymentOptionScreenState();
}

class _PaymentOptionScreenState extends State<PaymentOptionScreen> {
  int selectedRadio = 0;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  String buttonText = 'Agree';
  Color buttonColor = Colors.blue;
  TextStyle textStyle = TextStyle(color: Colors.white);
  bool isAgreed = false;
  String errorMessage="";
  int selectedOption = 0;
  String errorMessagePayment="";

  void changeButton() {
    setState(() {
      if (buttonText == 'Agree') {
        buttonText = 'Agreed';
        buttonColor = Colors.lightBlueAccent;
        textStyle = TextStyle(color: Colors.white);
        isAgreed = true;
        errorMessage = "";
      } else {
        buttonText = 'Agree';
        buttonColor = Colors.blue;
        textStyle = TextStyle(color: Colors.white);
        isAgreed = false;
      }
    });
  }

  void checkAgreement() {
    setState(() {
      if (!isAgreed) {
        errorMessage = 'You must agree the terms and condtions!';
      } else {
        errorMessage = '';
        if(selectedOption == 1){
          Navigator.pushNamed(context, "/payment");
        }
        else if(selectedOption == 2){
          Navigator.pushNamed(context, "/orderConfirmed");
        }
        else{
          errorMessagePayment = 'You must select payment method!';
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const CustomAppBar(title: "Payment Option"),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 10,
                  offset: const Offset(0, 3),
                ),
                const BoxShadow(
                  color: Colors.white,
                  blurRadius: 15,
                  spreadRadius: 15,
                  offset: Offset(0, 3),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Agree to our ',
                          style: TextStyle(fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Terms and Conditions'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                          'Welcome to BLUE Rent-a-Car service!\n\n'
                                              'By using our service, you agree to the following terms and conditions:\n\n'
                                              '1. You must have a valid driver\'s license.\n\n'
                                              '2. The car must be returned in the same condition it was rented.\n\n'
                                              '3. Any damages caused during the rental period are the responsibility of the renter.\n\n'
                                              '4. Rental fees must be paid in full upon return.\n\n'
                                              '5. Any violation of traffic rules or laws is the responsibility of the renter.\n\n'
                                              'Thank you for choosing our service!',
                                        ),
                                        SizedBox(height: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                                          child: Text('OK', style: TextStyle(color: Colors.white),),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Terms and conditions',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                        ),
                        onPressed: () {
                          changeButton();
                        },

                        child: Text(
                          buttonText,
                          style: textStyle,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    if(errorMessage.isNotEmpty)
                      Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 15,),
                      ),
                  ],
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 15, left: 20, bottom: 10),
                margin: const EdgeInsets.only(bottom: 15),
                child: const Text("Choose your payment method:",
                    style: TextStyle(fontSize: 18)),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      blurRadius: 15,
                      spreadRadius: 15,
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
                child: Column(
                  children: [
                    RadioListTile(
                      activeColor: Colors.blue,
                      value: 1,
                      groupValue: selectedRadio,
                      title: const Text('Debit/Credit Card'),
                      onChanged: (val) {
                        setSelectedRadio(val!);
                        setState((){
                          selectedOption = val!;
                        });
                      },
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.5),
                      )),
                      child: RadioListTile(
                        activeColor: Colors.blue,
                        value: 2,
                        groupValue: selectedRadio,
                        title: const Text('Wallet'),
                        onChanged: (val) {
                          setSelectedRadio(val!);
                          setState(() {
                            selectedOption = val!;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    if(errorMessagePayment.isNotEmpty)
                      Text(
                        errorMessagePayment,
                        style: TextStyle(color: Colors.red, fontSize: 15,),
                      ),
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.grey, width: 0.5))),
                  padding: const EdgeInsets.only(
                      bottom: 14, left: 14, right: 14, top: 30),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "3600MKD",
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // shadowButton("Checkout", "/payment")
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container( //SENKITE NA KOPCETO KUTI NA DR SCREEN
              // width: MediaQuery.of(context).size.width * 0.8,
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.grey.withOpacity(0.3),
              //       blurRadius: 15,
              //       spreadRadius: 15,
              //       offset: const Offset(0, 3),
              //     ),
              //     const BoxShadow(
              //       color: Colors.white,
              //       blurRadius: 15,
              //       spreadRadius: 4,
              //       offset: Offset(0, 3),
              //     ),
              //     BoxShadow(
              //       color: Colors.grey.withOpacity(0.3),
              //       blurRadius: 15,
              //       spreadRadius: 15,
              //       offset: const Offset(0, 3),
              //     ),
              //   ],
              // ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                      onPressed: (){
                        checkAgreement();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isAgreed ? Colors.blue : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        "Checkout",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                                  ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
