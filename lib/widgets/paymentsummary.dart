// paymentsummary.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brewmate_coffee_app/provider/orderprovider.dart';

class Paymentsummary extends StatefulWidget {
  final double subtotal;
  final double deliveryFee;
  final double total;
  final VoidCallback onPlaceOrder;
  final int initialTabIndex;

  const Paymentsummary({
    Key? key,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.onPlaceOrder,
    this.initialTabIndex = 0,
  }) : super(key: key);

  @override
  State<Paymentsummary> createState() => _PaymentsummaryState();
}

class _PaymentsummaryState extends State<Paymentsummary> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String deliveryNote = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialTabIndex);

    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    if (widget.initialTabIndex == 0) {
      orderProvider.setPickupAddress();
    } else {
      orderProvider.calculateDeliveryFeeFromCurrentLocation();
    }

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      if (_tabController.index == 0) {
        orderProvider.setPickupAddress();
      } else {
        orderProvider.calculateDeliveryFeeFromCurrentLocation();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final deliveryFee = orderProvider.deliveryFee;

    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(12),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: const [
              Tab(child: Text("Pick Up")),
              Tab(child: Text("Delivery")),
            ],
          ),
        ),
        SizedBox(
          height: 420,
          child: TabBarView(
            controller: _tabController,
            children: [
              _pickupOption(),
              _deliveryOption(deliveryFee),
            ],
          ),
        ),
      ],
    );
  }

  Widget _pickupOption() {
    return _buildCard(
      title: "Payment Summary (Pick Up)",
      children: [
        _summaryRow("Subtotal", "\$${widget.subtotal.toStringAsFixed(2)}"),
        _summaryRow("Delivery", "\$0.00"),
        _summaryRow("Total", "\$${widget.subtotal.toStringAsFixed(2)}"),
        const SizedBox(height: 15),
        _placeOrderButton(),
      ],
    );
  }

  Widget _deliveryOption(double fee) {
    return _buildCard(
      title: "Payment Summary (Delivery)",
      children: [
        _summaryRow("Subtotal", "\$${widget.subtotal.toStringAsFixed(2)}"),
        _summaryRow("Delivery", "\$${fee.toStringAsFixed(2)}"),
        _summaryRow("Total", "\$${widget.total.toStringAsFixed(2)}"),
        const SizedBox(height: 10),
        const Divider(),
        _placeOrderButton(),
      ],
    );
  }

  Widget _summaryRow(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...children,
        ],
      ),
    );
  }

  Widget _placeOrderButton() {
    return ElevatedButton(
      onPressed: widget.onPlaceOrder,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text("Place Order"),
    );
  }
}
