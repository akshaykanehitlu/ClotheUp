import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'catalog_page.dart';
import 'profile_page.dart';
import 'order_details.dart';
import 'orders_page.dart';

class OrderConfirmedPage extends StatelessWidget {
  final int orderNumber;
  final DateTime deliveryDate;
  final String pickupLocation;
  final int totalItems;

  OrderConfirmedPage({
    required this.orderNumber,
    required this.deliveryDate,
    required this.pickupLocation,
    required this.totalItems
  });


  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MM-dd-yyyy');

    OrderDetails order = OrderDetails(
      orderNumber: orderNumber,
      orderDate: DateTime.utc(2023, 7, 27),
      deliveryDate: deliveryDate,
      pickupLocation: pickupLocation,
      numberOfItems: totalItems,
    );

    orders.add(order);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Order Confirmation'),
        actions: [
          IconButton(
            onPressed: () {
              String username = 'username';

              Navigator.pushNamed(
                context,
                ProfilePage.routeName,
                arguments: {'username': username},
              );
            },
            icon: Icon(Icons.person), // Add the profile button to the app bar
          ),
        ],
      ),
      body: Center(
        // Center align the content
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          // Add padding to the left and right of the screen
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // Center align the content vertically
            crossAxisAlignment: CrossAxisAlignment.center,
            // Center align the card and text inside it
            children: [
              Text(
                'Hooray! Your order is confirmed!',
                // Add the message
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                // Change text label color to white
              ),
              SizedBox(height: 24),
              Card(
                // Add a card behind the order number and delivery date text
                color: Colors.white,
                // Set the card background color to white
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Number: $orderNumber',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF201A25)),
                        // Change text label color to #201A25
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Number of Items: $totalItems',
                        // Show today's date
                        style: TextStyle(fontSize: 18, color: Color(0xFF201A25)),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Pickup Location: $pickupLocation',
                        style: TextStyle(fontSize: 18, color: Color(0xFF201A25)),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Order Date: ${dateFormat.format(DateTime.now())}',
                        // Show today's date
                        style: TextStyle(fontSize: 18, color: Color(0xFF201A25)),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Pickup Date: ${dateFormat.format(deliveryDate)}',
                        style: TextStyle(fontSize: 18, color: Color(0xFF201A25)),
                        // Change text label color to #201A25
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              // Add some spacing between the card and the buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrdersPage(orders: [
                            OrderDetails(
                              orderNumber: orderNumber,
                              orderDate: DateTime.now(),
                              deliveryDate: deliveryDate,
                              pickupLocation: pickupLocation,
                              numberOfItems: totalItems, // Replace this with the actual number of items
                            ),
                          ]),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF292D32),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      'Orders',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CatalogPage.routeName); // Navigate to the CatalogPage
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF292D32),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      'Back to Catalog',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
