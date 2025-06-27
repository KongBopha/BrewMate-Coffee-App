// ignore_for_file: avoid_unnecessary_containers
import 'package:brewmate_coffee_app/widgets/customBottomNavBar.dart';
import 'dart:io';

import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
                padding: const EdgeInsets.only(top: 65, left: 10),
                color: Colors.orange,
                height: 150,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align text to the left
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_back_ios),
                            ),
                            const Text(
                              'Notification',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'You have 3 new notifications',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 111, 110, 110),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '16/12/2025',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1.0,
                    ),
                  ),
                ),
                // color: const Color.fromARGB(255, 244, 242, 242),
                // height: 20,
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.zero, // sharp rectangle corners
                            child: Image.asset(
                              'assets/aba.png',
                              width: 45,
                              height: 45,
                              fit: BoxFit.cover, // crop if needed
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Column(
                            children: [
                              Text(
                                'You have ordered Ice Latte',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: const Row(
                        children: [
                          Text(
                            'just now',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1.0,
                    ),
                  ),
                ),
                // color: const Color.fromARGB(255, 244, 242, 242),
                // height: 20,
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  
                    Container(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.zero, // sharp rectangle corners
                            child: Image.asset(
                              'assets/aba.png',
                              width: 45,
                              height: 45,
                              fit: BoxFit.cover, // crop if needed
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Column(
                            children: [
                              Text(
                                'You have ordered Ice Latte',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: const Row(
                        children: [
                          Text(
                            'just now',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1.0,
                    ),
                  ),
                ),
                // color: const Color.fromARGB(255, 244, 242, 242),
                // height: 20,
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.zero, // sharp rectangle corners
                            child: Image.asset(
                              'assets/aba.png',
                              width: 45,
                              height: 45,
                              fit: BoxFit.cover, // crop if needed
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Column(
                            children: [
                              Text(
                                'You have ordered Ice Latte',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: const Row(
                        children: [
                          Text(
                            'just now',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
