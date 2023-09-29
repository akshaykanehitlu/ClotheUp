import 'package:flutter/material.dart';
import 'order_details.dart';
import 'package:intl/intl.dart';

class SuccessfulOrdersPage extends StatelessWidget {
  final List<OrderDetails>? successfulOrders;

  SuccessfulOrdersPage({this.successfulOrders});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MM-dd-yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text('Successful Orders'),
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
        child: successfulOrders == null || successfulOrders!.isEmpty
            ? Center(
          child: Text(
            'No successful orders',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        )
            : ListView.builder(
          itemCount: successfulOrders!.length,
          itemBuilder: (context, index) {
            final order = successfulOrders![index];
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
              ),
            );
          },
        ),
      ),
    );
  }
}
