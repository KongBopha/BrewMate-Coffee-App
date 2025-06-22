import 'dart:io';

import 'package:flutter/material.dart';

class PickUpScreen extends StatefulWidget {
  const PickUpScreen({super.key});

  @override
  State<PickUpScreen> createState() => _PickUpScreenScreenState();
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int count = 1;

  void _increment() {
    setState(() => count++);
  }

  void _decrement() {
    if (count > 0) setState(() => count--);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton(Icons.remove, _decrement),
        const SizedBox(width: 20),
        Text(
          '$count',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 20),
        _buildButton(Icons.add, _increment),
      ],
    );
  }
}

Widget _buildButton(IconData icon, VoidCallback onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade400, width: 1),
      ),
      child: Icon(icon, size: 18, color: Colors.black87),
    ),
  );
}

class _PickUpScreenScreenState extends State<PickUpScreen> {
  bool isClicked = false;
  int count = 1;

  void _increment() {
    setState(() => count++);
  }

  void _decrement() {
    if (count > 0) setState(() => count--);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.orange,
                    height: 300,
                    width: 400,
                    child: Padding(
                      padding: EdgeInsets.only(top: 70, left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on_outlined,
                                  color: Colors.white, size: 40),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Welcome to BrewMate',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Tuol Kork, Phnom Penh',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70,
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),

                              /// Circular outline user icon
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                child: const Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: Colors.white,
                            height: 150,
                            width: 330,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Delivery Address',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('2nd Door Emi'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Tuol Kork, Phnom Penh',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      height: 1.2,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.grey,
                                            side: const BorderSide(
                                              color: Colors.grey,
                                              width: 1.0, // 👈 Thin border
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.movie_edit),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Edit Address',
                                                style: TextStyle(),
                                              ),
                                            ],
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      TextButton(
                                          onPressed: () {},
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.grey,
                                            side: const BorderSide(
                                              color: Colors.grey,
                                              width: 1.0, // 👈 Thin border
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.note_add_outlined),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Add Note',
                                                style: TextStyle(),
                                              ),
                                            ],
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    height: 40,
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 45, left: 45),
                          child: Row(
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Delivery',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 45, left: 45),
                          color: Colors.orange,
                          child: Row(
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Pick Up',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    // padding: EdgeInsets.all(10),
                    color: const Color.fromARGB(255, 221, 220, 220),
                    height: 320,
                    width: 350,
                    child: Column(
                      children: [
                        Container(
                          // padding: EdgeInsets.all(10),
                          color: Colors.white,
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/vattanak.png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 17,
                                        ),
                                        Text(
                                          'Cappucino',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          'with Cocolate',
                                          style: TextStyle(
                                              fontSize: 10, color: Colors.grey),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    _buildButton(Icons.remove, _increment),
                                    const SizedBox(width: 20),
                                    Text(
                                      '$count',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(width: 20),
                                    _buildButton(Icons.add, _increment),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          height: 70,
                          child: Column(
                            children: [
                              Text(
                                'Payment Summary',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Pice'),
                                  Text('1.50'),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          height: 170,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total Payment'),
                                  Text('1.50'),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.orange,
                                      ),
                                      child: Text(
                                        'Choose Payment Method',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color.fromARGB(
                                                        255, 132, 241, 135)),
                                          ),
                                          child: Text('Cash'),
                                        ),
                                        SizedBox(
                                          width: 17,
                                        ),
                                        Text('1.50'),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 330,
                                    height: 50,
                                    child: TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.orange,
                                        // shape: const CircleBorder(),
                                        padding: EdgeInsets.all(2),
                                      ),
                                      child: Text(
                                        'Plase Order',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          width: 100,
          height: 80,
          color: const Color.fromARGB(255, 227, 227, 228),
          // padding: EdgeInsets.all(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.mail_outline)),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.local_drink_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_active_outlined))
            ],
          )),
    );
  }
}
