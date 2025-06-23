import 'package:brewmate_coffee_app/widgets/paymentsummary.dart';
import 'package:flutter/material.dart';
import 'package:brewmate_coffee_app/widgets/appbar_widget.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrewMateAppBar(
        onProfilePressed: () {
          // Handle profile action
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //  Block 1: Orange background with AddressContainer inside
            Container(
              width: double.infinity,
              color: Colors.orange,
              padding: const EdgeInsets.all(16),
              child: _AddressContainer(
                onEditAddress: () {},
                onAddNote: () {},
              ),
            ),

            const SizedBox(height: 16),

            // 🧾 Block 2: White card for Payment Summary
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: const Paymentsummary(),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressContainer extends StatelessWidget {
  final VoidCallback onEditAddress;
  final VoidCallback onAddNote;

  const _AddressContainer({
    required this.onEditAddress,
    required this.onAddNote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
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
          const Text(
            "Delivery Address",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "2nd Door Emi",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Carnation St., Sunflower Village, Brgy. Garden",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: onEditAddress,
                icon: const Icon(Icons.edit_location_alt_outlined, size: 18),
                label: const Text("Edit Address"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orange,
                  side: const BorderSide(color: Colors.orange),
                  textStyle: const TextStyle(fontSize: 13),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: onAddNote,
                icon: const Icon(Icons.note_add_outlined, size: 18),
                label: const Text("Add Note"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orange,
                  side: const BorderSide(color: Colors.orange),
                  textStyle: const TextStyle(fontSize: 13),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}