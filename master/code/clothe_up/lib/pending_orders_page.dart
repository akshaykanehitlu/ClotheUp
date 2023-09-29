import 'package:flutter/material.dart';
import 'order_details.dart';
import 'package:intl/intl.dart';
import 'successful_orders_page.dart';

class PendingOrdersPage extends StatefulWidget {
  final List<OrderDetails>? pendingOrders;

  PendingOrdersPage({this.pendingOrders});

  @override
  _PendingOrdersPageState createState() => _PendingOrdersPageState();
}

class _PendingOrdersPageState extends State<PendingOrdersPage> {

  final dateFormat = DateFormat('MM-dd-yyyy');

  void _moveToSuccessfulOrders(OrderDetails order) {
    setState(() {
      widget.pendingOrders!.remove(
          order); // Remove the order from pending orders
      successOrders.add(order); // Add the order to successful orders
    });

    // Show "Order delivered successfully!" dialog for 2 seconds and then close it.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });

        return Center(
          child: Container(
            width: 300,
            height: 150, // Reduced height for the dialog box
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 50),
                SizedBox(height: 10),
                Text(
                  'Order delivered successfully!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Orders'),
        centerTitle: true,
        backgroundColor: Color(0xFF273140),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF273140),
              Color(0xFF1E2D3B),
            ],
          ),
        ),
        child: widget.pendingOrders == null || widget.pendingOrders!.isEmpty
            ? Center(
          child: Text(
            'No pending orders',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        )
            : ListView.builder(
          itemCount: widget.pendingOrders!.length,
          itemBuilder: (context, index) {
            final order = widget.pendingOrders![index];
            return Card(
              color: Colors.white,
              elevation: 2,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(
                  'Order Number: ${order.orderNumber}',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Number of Items: ${order.numberOfItems}',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      'Pickup Location: ${order.pickupLocation}',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      'Order Date: ${dateFormat.format(order.orderDate)}',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      'Delivery Date: ${dateFormat.format(order.deliveryDate)}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        _moveToSuccessfulOrders(
                            order); // Move the order to successful orders
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          widget.pendingOrders!
                              .remove(order); // Remove the order from pending orders
                        });

                        // Show "Order failed to be delivered!" dialog for 2 seconds and then close it.
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                            });

                            return Center(
                              child: Container(
                                width: 300,
                                height: 150, // Reduced height for the dialog box
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error, color: Colors.red, size: 50),
                                    SizedBox(height: 10),
                                    Text(
                                      'Order failed to be delivered!',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
