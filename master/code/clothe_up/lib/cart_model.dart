import 'package:flutter/foundation.dart';
import 'cart_item.dart';

class CartModel with ChangeNotifier {
  List<CartItem> _cartItems = [];
  bool _showAddedToCartMessage = false; // Add the flag for showing the SnackBar message

  List<CartItem> get cartItems => _cartItems;

  // Add the getter for showing the SnackBar message
  bool get showAddedToCartMessage => _showAddedToCartMessage;

  // Add the method for setting the flag to show the SnackBar message
  void setShowAddedToCartMessage(bool value) {
    _showAddedToCartMessage = value;
    notifyListeners();
  }

  void addToCart(CartItem cartItem) {
    _cartItems.add(cartItem);
    _showAddedToCartMessage = true; // Set the flag to show the SnackBar message
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);
    notifyListeners();
  }

  int getTotalItems() {
    // Implement the logic to calculate the total number of items in the cart.
    int totalItems = 0;
    for (var item in _cartItems) {
      totalItems += item.quantity;
    }
    return totalItems;
  }
}
