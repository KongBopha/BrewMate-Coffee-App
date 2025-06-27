import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brewmate_coffee_app/provider/orderprovider.dart';

class PaymentMethodScreen extends StatefulWidget {
  final double subtotal;

  const PaymentMethodScreen({super.key, required this.subtotal});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? selectedMethod;

  void _selectMethod(String method) {
    setState(() {
      selectedMethod = method;
    });
  }

  void _confirmSelection() {
    if (selectedMethod != null) {
      Navigator.pop(context, selectedMethod);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a payment method')),
      );
    }
  }

  Widget _buildPaymentOption({
    required String label,
    required String description,
    required String assetPath,
  }) {
    return GestureDetector(
      onTap: () => _selectMethod(label),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selectedMethod == label ? Colors.orange : Colors.grey.shade300,
            width: 2,
          ),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Image.asset(assetPath, width: 40, height: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(description, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            Icon(
              Icons.check_circle,
              color: selectedMethod == label ? Colors.orange : Colors.grey,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final deliveryFee = orderProvider.deliveryFee;
    final total = widget.subtotal + deliveryFee;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Choose Payment Method'),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Colors.orange,
              child: Column(
                children: [
                  const Text('Total Amount', style: TextStyle(color: Colors.white, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Online Payment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 8),

            _buildPaymentOption(
              label: 'ACLEDA PAY',
              description: 'Pay with ACLEDA mobile app',
              assetPath: 'assets/ac.png',
            ),
            _buildPaymentOption(
              label: 'ABA PAY',
              description: 'Pay with ABA mobile app',
              assetPath: 'assets/aba.png',
            ),
            _buildPaymentOption(
              label: 'WING PAY',
              description: 'Pay with WING mobile app',
              assetPath: 'assets/wing.png',
            ),

            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Offline Payment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 8),

            _buildPaymentOption(
              label: 'Cash',
              description: 'Pay with cash on delivery',
              assetPath: 'assets/cash.png',
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: 300,
              height: 48,
              child: ElevatedButton(
                onPressed: _confirmSelection,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Confirm Payment Method', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
