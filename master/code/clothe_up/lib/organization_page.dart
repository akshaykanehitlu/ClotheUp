import 'package:flutter/material.dart';
import 'image_capture_page.dart';
import 'pending_orders_page.dart';
import 'order_details.dart';
import 'successful_orders_page.dart';
import 'inventory_page.dart';
import 'product.dart';
import 'login_page.dart';


class OrganizationPage extends StatelessWidget {
  static const String routeName = '/organization';

  Product newProduct = Product(productName: '', size: '', gender: '', imageUrl: '', productType: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Organization'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color(0xFF273140),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Color(0xFF273140),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Colors.transparent,
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          'The Salvation Army Thrift Store &',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' Donation Center',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/location.png',
                              width: 16,
                              height: 16,
                            ),
                            Text(
                              ' 702 W Taylor St, San Jose, CA 95126',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/timing.png',
                              width: 16,
                              height: 16,
                            ),
                            Text(
                              ' 9 AM–8 PM',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 64),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 32,
                            crossAxisSpacing: 32,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ImageCapturePage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 48),
                                      Image.asset(
                                        'assets/images/scannew.png',
                                        width: 48,
                                        height: 48,
                                      ),
                                      SizedBox(height: 16),
                                      Text('Add Product'),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PendingOrdersPage(pendingOrders: orders),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 48),
                                      Image.asset(
                                        'assets/images/pending.png',
                                        width: 48,
                                        height: 48,
                                      ),
                                      SizedBox(height: 16),
                                      Text('Pending Orders'),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SuccessfulOrdersPage(successfulOrders: successOrders),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 48),
                                      Image.asset(
                                        'assets/images/success.png',
                                        width: 48,
                                        height: 48,
                                      ),
                                      SizedBox(height: 16),
                                      Text('Success'),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InventoryPage(products: products, newProduct: newProduct,),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 48),
                                      Image.asset(
                                        'assets/images/inventory.png',
                                        width: 48,
                                        height: 48,
                                      ),
                                      SizedBox(height: 16),
                                      Text('Inventory'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/images/org_logo.png',
                        width: 64,
                        height: 64,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Add the logout button to the bottom of the Scaffold
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        color: Colors.transparent,
        child: ElevatedButton(
          onPressed: () {
            // When the logout button is pressed, navigate to the LoginPage
            Navigator.pushReplacementNamed(context, LoginPage.routeName);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // Change the button color to red
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Logout',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
