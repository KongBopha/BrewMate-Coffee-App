import 'package:brewmate_coffee_app/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'package:brewmate_coffee_app/provider/cartitem_provider.dart';
import 'package:brewmate_coffee_app/provider/orderprovider.dart';
import 'package:brewmate_coffee_app/widgets/appbar_widget.dart';
import 'package:brewmate_coffee_app/widgets/paymentsummary.dart';

class CheckoutScreen extends StatefulWidget {
  final int initialTabIndex;
  const CheckoutScreen({super.key, this.initialTabIndex = 0}); // 0 = Pickup

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _setDefaultPickupLocation();
  }

  void _setDefaultPickupLocation() {
    // Set a default pickup address (e.g., shop location)
    Provider.of<OrderProvider>(context, listen: false).setPickupAddress();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartItemProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    final cartItems = cartProvider.cartItems;

    final subtotal = cartItems.fold<double>(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
    final deliveryFee = orderProvider.deliveryFee;
    final total = subtotal + deliveryFee;

    return Scaffold(
      appBar: BrewMateAppBar(onProfilePressed: () {}),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _AddressContainer(
              onEditAddress: _openMapPicker,
              onAddNote: _showNoteDialog,
            ),
              Paymentsummary(
                subtotal: subtotal,
                deliveryFee: deliveryFee,
                total: total,
                initialTabIndex: widget.initialTabIndex,
                onPlaceOrder: () async {
                  setState(() => isLoading = true);

                  await orderProvider.placeOrder(cartItems, total);
                  // Clear the cart after placing the order
                  cartProvider.clearCart();
                  cartProvider.clearLocalCart();

                  setState(() => isLoading = false);

                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Order placed successfully!')),
                  );

                  // Navigate to HomeScreen and clear back stack
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                    arguments: 0,
                  );
                },
              ),

          ],
        ),
      ),
    );
  }

  Future<void> _openMapPicker() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final selectedLocation = LatLng(position.latitude, position.longitude);

      await Provider.of<OrderProvider>(context, listen: false)
          .setAddressFromCoordinates(
        selectedLocation.latitude,
        selectedLocation.longitude,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to get location")),
      );
    }
  }

  Future<bool> _handleLocationPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!mounted) return false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied')),
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location permission permanently denied. Please enable it in settings.',
          ),
        ),
      );
      return false;
    }

    return true;
  }

  void _showNoteDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Note"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '  Please call upon arrival',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<OrderProvider>(context, listen: false)
                  .setNote(controller.text);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
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
    final orderProvider = Provider.of<OrderProvider>(context);
    final address = orderProvider.userAddress.isNotEmpty
        ? orderProvider.userAddress
        : "No address selected";
    final note = orderProvider.userNote;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 12),
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
          const Text("Delivery Address",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(address, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (note.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text("Note: $note", style: const TextStyle(color: Colors.grey)),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: onEditAddress,
                icon: const Icon(Icons.edit_location_alt_outlined),
                label: const Text("Edit Address"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orange,
                  side: const BorderSide(color: Colors.orange),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: onAddNote,
                icon: const Icon(Icons.note_add_outlined),
                label: const Text("Add Note"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orange,
                  side: const BorderSide(color: Colors.orange),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
