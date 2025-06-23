// ignore_for_file: avoid_unnecessary_containers

import 'dart:io';

import 'package:flutter/material.dart';

class MyFavoriteScreen extends StatefulWidget {
  const MyFavoriteScreen({super.key});

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
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
                padding: const EdgeInsets.only(top: 35, left: 10),
                color: Colors.orange,
                height: 110,
                child: Row(
                  children: [
                    // SizedBox(
                    //   height: 30,
                    // ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
                    const Text(
                      'My Favorite',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
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
                color: const Color.fromARGB(255, 244, 242, 242),
                // height: 20,
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/aba.png',
                            width: 45,
                            height: 45,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Column(
                            children: [
                              Text(
                                'Capocino',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'with Choloate',
                                style: TextStyle(fontSize: 10),
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
                            '1.5',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.orange,
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
                color: const Color.fromARGB(255, 244, 242, 242),
                // height: 20,
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/aba.png',
                            width: 45,
                            height: 45,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Column(
                            children: [
                              Text(
                                'Capocino',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'with Choloate',
                                style: TextStyle(fontSize: 10),
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
                            '1.5',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.orange,
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
                color: const Color.fromARGB(255, 244, 242, 242),
                // height: 20,
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/aba.png',
                            width: 45,
                            height: 45,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Column(
                            children: [
                              Text(
                                'Capocino',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'with Choloate',
                                style: TextStyle(fontSize: 10),
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
                            '1.5',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
