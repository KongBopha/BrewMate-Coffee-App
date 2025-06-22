import 'dart:io';

import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            // child: Padding(
            // padding: EdgeInsets.only(left: 40, right: 40, bottom: 80),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.,
              children: [
                Container(
                  color: Colors.orange,
                  height: 210,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 60),
                          Icon(Icons.arrow_back_ios),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Choose Payment Method',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(270, 40)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white), // width: 200, height: 50
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        '1.6',
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6),
                      Text(
                        '= 6000 ',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.grey,
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // children: [
                    //   Row(
                    children: [
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Support Online Payment',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        // padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0, // adjust thickness
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/ac.png',
                                width: 40,
                                height: 40,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'ACLEDA PAY',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Tep to pay with ACLEDA mobile',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.check_circle,
                                  color:
                                      isClicked ? Colors.orange : Colors.grey,
                                  size: 28,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isClicked = !isClicked; // Toggle the state
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        // padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0, // adjust thickness
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/aba.png',
                                width: 40,
                                height: 40,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'ABA PAY',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Tep to pay with ACLEDA mobile',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.check_circle,
                                  color:
                                      isClicked ? Colors.orange : Colors.grey,
                                  size: 28,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isClicked = !isClicked; // Toggle the state
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        // padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0, // adjust thickness
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/wing.png',
                                width: 40,
                                height: 40,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'WING PAY',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Tep to pay with ACLEDA mobile',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.check_circle,
                                  color:
                                      isClicked ? Colors.orange : Colors.grey,
                                  size: 28,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isClicked = !isClicked; // Toggle the state
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        // padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0, // adjust thickness
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/kanadia.png',
                                width: 40,
                                height: 40,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'CANADIA PAY',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Tep to pay with ACLEDA mobile',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.check_circle,
                                  color:
                                      isClicked ? Colors.orange : Colors.grey,
                                  size: 28,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isClicked = !isClicked; // Toggle the state
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/vattanak.png',
                              width: 40,
                              height: 40,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'VATTANAK PAY',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Tep to pay with ACLEDA mobile',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.check_circle,
                                color: isClicked ? Colors.orange : Colors.grey,
                                size: 28,
                              ),
                              onPressed: () {
                                setState(() {
                                  isClicked = !isClicked; // Toggle the state
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                    //   )
                    // ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.grey,
                  )),
                  child: Column(
                    children: [
                      Text(
                        'Offline Payment',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.delivery_dining_outlined,
                            size: 40,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'CASH ON DELIVERY',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Tep here to pay offline with delivery',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.check_circle,
                              color: isClicked ? Colors.orange : Colors.grey,
                              size: 28,
                            ),
                            onPressed: () {
                              setState(() {
                                isClicked = !isClicked; // Toggle the state
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(270, 50)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.orange), // width: 200, height: 50
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                )
              ],
            ),
            // ),
          )
        ],
      ),
    );
  }
}
