// paymentsummary.dart
import 'package:brewmate_coffee_app/provider/cartitem_provider.dart';
import 'package:brewmate_coffee_app/views/paymentMethod/payment_method.dart';
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

class _PaymentsummaryState extends State<Paymentsummary>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedPaymentMethod = "Choose Payment Method";

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: widget.initialTabIndex);

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
    color: Colors.orange.shade600,
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        color: Colors.orange.withOpacity(0.4),
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  ),
  labelColor: Colors.white,
  unselectedLabelColor: Colors.orange,
  labelStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
  unselectedLabelStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  indicatorPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
  padding: const EdgeInsets.symmetric(vertical: 6),
  tabs: const [
    Tab(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Text("Pick Up"),
      ),
    ),
    Tab(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Text("Delivery"),
      ),
    ),
  ],
),

        ),
        SizedBox(
          height: 480,
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
        _summaryRow("Payment Method", selectedPaymentMethod,
            isButton: true, onTap: _selectPaymentMethod),
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
        _summaryRow("Payment Method", selectedPaymentMethod,
            isButton: true, onTap: _selectPaymentMethod),
        _summaryRow("Total", "\$${widget.total.toStringAsFixed(2)}"),
        const SizedBox(height: 10),
        const Divider(),
        _placeOrderButton(),
      ],
    );
  }

  Widget _summaryRow(String label, String value,
      {bool isButton = false, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          isButton
              ? InkWell(
                  onTap: onTap,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                )
              : Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
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
          Text(title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

void _selectPaymentMethod() async {
  final cartProvider = Provider.of<CartItemProvider>(context, listen: false);
  final subtotal = cartProvider.cartItems.fold<double>(
    0.0,
    (sum, item) => sum + item.price * item.quantity,
  );

  final selectedMethod = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => PaymentMethodScreen(subtotal: subtotal),
    ),
  );

  if (selectedMethod != null && selectedMethod is String) {
    setState(() {
      selectedPaymentMethod = selectedMethod;
    });
  }
}
}
