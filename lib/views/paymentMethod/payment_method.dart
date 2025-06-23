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
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 60),
                          const Icon(Icons.arrow_back_ios),
                          TextButton(
                            onPressed: () {},
                            // ignore: sort_child_properties_last
                            child: const Text(
                              'Choose Payment Method',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(270, 40)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white), // width: 200, height: 50
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        '1.6',
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        '= 6000 ',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.grey,
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // children: [
                    //   Row(
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'Support Online Payment',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        // padding: EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0, // adjust thickness
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/ac.png',
                                width: 40,
                                height: 40,
                              ),
                              const Column(
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
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0, // adjust thickness
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/aba.png',
                                width: 40,
                                height: 40,
                              ),
                              const Column(
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
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0, // adjust thickness
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/wing.png',
                                width: 40,
                                height: 40,
                              ),
                              const Column(
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
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0, // adjust thickness
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/kanadia.png',
                                width: 40,
                                height: 40,
                              ),
                              const Column(
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
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/vattanak.png',
                              width: 40,
                              height: 40,
                            ),
                            const Column(
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
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.grey,
                  )),
                  child: Column(
                    children: [
                      const Text(
                        'Offline Payment',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.delivery_dining_outlined,
                            size: 40,
                          ),
                          const Column(
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
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(const Size(270, 50)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.orange), // width: 200, height: 50
                  ),
                  child: const Text(
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
