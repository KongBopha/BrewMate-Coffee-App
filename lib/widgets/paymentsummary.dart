import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Paymentsummary extends StatelessWidget {
  const Paymentsummary({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _deliveryOptions(),
          const SizedBox(height: 20,),
          
          //fetch cartItem data
          //Payment summary
          // price
          //DeliveryFee
          // total payment
          // choose payment method
          //place order navigate to delivery screen
        
        ],
      ),
    );
  }
  Widget _deliveryOptions(){
    return Container(

    );
  }
}