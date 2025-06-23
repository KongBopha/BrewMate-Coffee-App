import 'package:flutter/material.dart';

class Paymentsummary extends StatelessWidget {
  const Paymentsummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _deliveryOptions(),
       
      ],
    );
  }

  Widget _deliveryOptions() {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            indicator: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(12), 
            ),
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),  
            labelPadding: const EdgeInsets.symmetric(horizontal: 16),  
            unselectedLabelColor: Colors.black,
            labelColor: Colors.white,
            tabs: const [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Pick Up'),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Delivery'),
                ),
              ),
            ],
          ),
            SizedBox(
            height: 300, 
            child: TabBarView( 
              children: [
                _pickupOption(),
              const  Center(child: Text('Bonjour')),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _pickupOption(){
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration:const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // fetch data from cartItem
          const Text("Payment Summary", 
          style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold,
          ),
          ),
          //fetch data from order
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Choose Payment Method',
              style:TextStyle(
                backgroundColor: Colors.orange[300],
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold
              ),
              ),
            const  Text('Cash',
              style: TextStyle(
                backgroundColor: Colors.green,
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold
              ),
              ),
              // Payment method render
            ],
          ),
          const SizedBox(height: 15,),
          ElevatedButtonTheme(
            data: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,  
                foregroundColor: Colors.white,  
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                // Handle place order logic
              },
              child: const Text('Place Order'),
            ),
          )
        ],

        ),
    );
  }
}
