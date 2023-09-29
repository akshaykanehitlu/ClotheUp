class CartItem {
  final String title;
  final String assetName;
  final String? size;
  int quantity;

  CartItem({
    required this.title,
    required this.assetName,
    required this.size,
    this.quantity = 1,
  });
}