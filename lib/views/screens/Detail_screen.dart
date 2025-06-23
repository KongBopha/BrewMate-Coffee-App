import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final List<Map<String, dynamic>> recommendedProducts = [
    {
      "image": "assets/detailpage/caff-01.png",
      "title": "Decaf",
      "subtitle": "Classic",
      "price": 1.75,
      "ratinf": 4.8
    },
    {
      "image": "assets/detailpage/caff-02.png",
      "title": "Decaf",
      "subtitle": "Chiaro",
      "price": 1.50,
      "rating": 5.0
    },
    {
      "image": "assets/detailpage/caff-03.png",
      "title": "Decaf",
      "subtitle": "Chiaro",
      "price": 1.50,
      "rating": 5.0
    },
    {
      "image": "assets/detailpage/caff-02.png",
      "title": "Decaf",
      "subtitle": "Chiaro",
      "price": 1.50,
      "rating": 5.0
    },
    {
      "image": "assets/detailpage/caff-03.png",
      "title": "Decaf",
      "subtitle": "Chiaro",
      "price": 1.50,
      "rating": 5.0
    },
    {
      "image": "assets/detailpage/caff-02.png",
      "title": "Decaf",
      "subtitle": "Chiaro",
      "price": 1.50,
      "rating": 5.0
    },
  ];
  bool _isHovered = false;
  void onAddToCart(Map<String, dynamic> product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Added ${product["title"]} to cart!")),
    );
  }

  void onViewDetail(Map<String, dynamic> product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Viewing ${product["title"]} details...")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "About This Menu",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.favorite_border, color: Colors.black),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Center(
                child: Image.asset(
                  'assets/detailpage/caff-01.png',
                  width: 200,
                  height: 200,
                ),
              ),
              const SizedBox(height: 15),

              // Product name & price (left-aligned)
              Container(
                alignment: Alignment.centerLeft,
                //  margin: const EdgeInsets.only(bottom: 40),
                child: const Text(
                  'Cappuccino',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.centerLeft,
                // margin: const EdgeInsets.only(bottom: 50),
                child: const Text(
                  '\$ 6,45',
                  style: TextStyle(fontSize: 18, color: Colors.orange),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                // Row with icons and descriptions
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange),
                        SizedBox(width: 3),
                        Text("4.5", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        onAddToCart({
                          "title": "Cappuccino",
                          "price": 6.45,
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isHovered
                            ? const Color.fromARGB(255, 60, 250, 95)
                            : const Color.fromARGB(255, 255, 149, 35),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                // margin: const EdgeInsets.only(bottom: 30),
                child: const Text(
                  "Description",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Text(
                "Cappuccinos are typically served in smaller cups(around 5 to 6 ounces) compared to lattes,"
                "making the espresso flavor more pronounced.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recommended for you",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("See All", style: TextStyle(color: Colors.orange)),
                ],
              ),
              SizedBox(
                height: 750,
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: recommendedProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final product = recommendedProducts[index];
                      return GestureDetector(
                        onTap: () => onViewDetail(product),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      product["image"],
                                      width: double.infinity,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                      top: 6,
                                      left: 6,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.star,
                                                size: 14, color: Colors.white),
                                            const SizedBox(width: 2),
                                            Text(
                                              "${product["rating"] ?? product["ratinf"]}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(product["title"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text(product["subtitle"],
                                  style: const TextStyle(color: Colors.grey)),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("\$ ${product["price"]}"),
                                  GestureDetector(
                                    onTap: () => onAddToCart(product),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.add,
                                          size: 16, color: Colors.white),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
