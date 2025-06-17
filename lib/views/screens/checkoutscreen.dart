import 'package:flutter/material.dart';
import 'package:brewmate_coffee_app/widgets/appbar_widget.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: BrewMateAppBar(
        onProfilePressed: () {
          // Handle profile action
        },
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            _AddressContainer(
              onEditAddress: () {
                // Handle edit address
              },
              onAddNote: () {
                // Handle add note
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 👇🏻 Private reusable widget inside this file
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
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Delivery Address",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "2nd Door Emi",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const Text(
            "Carnation St., Sunflower Village, Brgy. Garden",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: onEditAddress,
                icon: const Icon(Icons.edit_location_alt_outlined),
                label: const Text("Edit Address"),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: onAddNote,
                icon: const Icon(Icons.note_add_outlined),
                label: const Text("Add Note"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
