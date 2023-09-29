import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_item.dart';
import 'cart_model.dart';
import 'order_confirmed_page.dart';
import 'dart:math';

class CartPage extends StatefulWidget {
  static const String routeName = '/cart';

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<CartItem, int> quantities = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update the quantities map whenever cartItems change
    var cartModel = Provider.of<CartModel>(context);
    for (var cartItem in cartModel.cartItems) {
      if (!quantities.containsKey(cartItem)) {
        quantities[cartItem] = 1;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize the quantities map with default values of 1
    var cartModel = Provider.of<CartModel>(context, listen: false);
    for (var cartItem in cartModel.cartItems) {
      quantities[cartItem] = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    var cartModel = Provider.of<CartModel>(context);
    var cartItems = cartModel.cartItems;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Cart'),
      ),
      body: cartItems.isEmpty // Check if the cart is empty
          ? _buildEmptyCartPage()
          : Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return _buildCartItemCard(cartItems[index]);
                      },
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.28,
            // 30% of the bottom screen
            padding: EdgeInsets.symmetric(horizontal: 16),
            // Padding on left and right
            color: Color(0xFFB3B6BB),
            // Use a light gray background for the gray area
            child: _buildCartDetails(context, cartModel),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemCard(CartItem cartItem) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              cartItem.assetName,
              height: 80,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Size: ${cartItem.size}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            _buildQuantityButtons(cartItem),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButtons(CartItem cartItem) {
    int quantity = quantities[cartItem] ?? 1;

    return Column(
      children: [
        IconButton(
          onPressed: () => _incrementQuantity(cartItem),
          icon: Icon(Icons.add), // Swap "+" and "-"
        ),
        Text(
          quantity.toString(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () => _decrementQuantity(cartItem),
          icon: Icon(Icons.remove), // Swap "+" and "-"
        ),
      ],
    );
  }

  void _incrementQuantity(CartItem cartItem) {
    setState(() {
      int quantity = quantities[cartItem] ?? 1;
      quantities[cartItem] = quantity + 1;
    });
  }

  void _decrementQuantity(CartItem cartItem) {
    setState(() {
      int quantity = quantities[cartItem] ?? 1;
      if (quantity > 1) {
        quantities[cartItem] = quantity - 1;
      } else {
        // Remove product from the cart if quantity is less than 1
        var cartModel = Provider.of<CartModel>(context, listen: false);
        cartModel.removeFromCart(cartItem);
        quantities.remove(cartItem);
      }
    });
  }

  Widget _buildCartDetails(BuildContext context, CartModel cartModel) {
    // Calculate the total items count by summing the quantities of each item
    int totalItemsCount = quantities.values.reduce((sum, quantity) => sum + quantity);

    String selectedAddress = ''; // Store the selected address here

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Total Items: $totalItemsCount',
          style: TextStyle(fontSize: 18, color: Color(0xFF040415)),
        ),
        SizedBox(height: 16),
        Text(
          'Pickup Location:',
          style: TextStyle(fontSize: 18, color: Color(0xFF040415)),
        ),
        SizedBox(height: 8),
        _buildDummyAddressDropDown((newValue) {
          selectedAddress = newValue; // Update the selected address
        }),
        SizedBox(height: 24), // Add some additional spacing
        SizedBox(
          width: double.infinity, // Take the full available width
          child: ElevatedButton(
            onPressed: () {
              if (selectedAddress.isNotEmpty) {
                final orderNumber = Random().nextInt(100000);
                final currentDate = DateTime.now();
                final deliveryDate = currentDate.add(Duration(days: 14));

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderConfirmedPage(
                      orderNumber: orderNumber,
                      deliveryDate: deliveryDate,
                      pickupLocation: selectedAddress, // Pass the selected address to the OrderConfirmedPage
                      totalItems: totalItemsCount, // Pass the total number of items to the OrderConfirmedPage
                    ),
                  ),
                );
              } else {
                // Show a dialog with an error message when no address is selected
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text(
                        'Please select a pickup location before checking out.'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF292D32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Add curved edges
              ),
              padding:
              EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Increase button size
            ),
            child: Text(
              'CHECK OUT',
              style: TextStyle(
                  color: Colors.white, fontSize: 18), // Increase button text size
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDummyAddressDropDown(void Function(String) onAddressSelected) {
    List<String> dummyAddresses = [
      '------', // Add a default option with dashes
      '123 Main Street',
      '456 Elm Avenue',
      '789 Oak Lane',
    ];

    String selectedAddress = dummyAddresses[0];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
            8), // Add curved edges to the dropdown
      ),
      child: DropdownButtonFormField<String>(
        value: selectedAddress,
        onChanged: (newValue) {
          if (newValue != '---------------') {
            onAddressSelected(
                newValue!); // Notify the parent widget about the selected address
          }
        },
        items: dummyAddresses.map((address) {
          return DropdownMenuItem<String>(
            value: address,
            child: Text(address),
          );
        }).toList(),
      ),
    );
  }

  // Empty cart page
  Widget _buildEmptyCartPage() {
    return Center(
      child: Text(
        'Your cart is empty',
        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
