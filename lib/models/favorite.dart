class FavoriteItem {
  final String productId;

  FavoriteItem({required this.productId});

  Map<String, dynamic> toJson() => {
    'productId': productId,
  };

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(productId: json['productId']);
  }
}
