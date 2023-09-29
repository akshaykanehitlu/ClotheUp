class OrderDetails {
  final int orderNumber;
  final DateTime orderDate;
  final DateTime deliveryDate;
  final String pickupLocation;
  final int numberOfItems;

  OrderDetails({
    required this.orderNumber,
    required this.orderDate,
    required this.deliveryDate,
    required this.pickupLocation,
    required this.numberOfItems,
  });
}

final List<OrderDetails> orders = [];
final List<OrderDetails> successOrders = [];