import 'package:flutter/material.dart';
import 'package:brewmate_coffee_app/models/products.dart';

class CardWidget extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const CardWidget({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,  
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Centered product image
              Center(
                child: product.imageUrl != null
                    ? Image.asset(
                        product.imageUrl!,
                        height: 130,
                        width: 130,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.local_cafe, size: 90, color: Colors.brown),
              ),

              const SizedBox(height: 8),

              // Product name
              Text(
                product.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                product.description ?? '',
                style:  TextStyle(fontSize: 12, color: Colors.grey[700]),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8),

              // Price + add button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: onAddToCart,
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.add, size: 24, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Rating badge
          Positioned(
            top: -6,
            left: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, size: 12, color: Colors.amber),
                  SizedBox(width: 2),
                  Text("4.8", style: TextStyle(color: Colors.white, fontSize: 10)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


