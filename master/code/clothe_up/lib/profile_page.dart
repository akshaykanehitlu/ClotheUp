import 'package:flutter/material.dart';
import 'login_page.dart';
import 'orders_page.dart';
import 'order_details.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = '/profile';
  final String username;

  ProfilePage({Key? key, required this.username}) : super(key: key);

  void _handleLogout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName, (route) => false);
  }

  void _navigateToOrdersPage(BuildContext context) {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrdersPage(orders: orders), // Pass the list of order details to the OrdersPage
      ),
    );
  }

  void _navigateToAccountSettings(BuildContext context) {
    // Implement navigation logic to the account settings page here
  }

  void _navigateToGeneralSettings(BuildContext context) {
    // Implement navigation logic to the general settings page here
  }

  Widget _buildClickableContainer(String title, String subtitle, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFF273140),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Color(0xFF273140),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            Icon(
              Icons.arrow_forward,
              color: Color(0xFF273140),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF273140),
              Color(0xFF273140),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Image.asset(
                  'assets/images/profile_icon.png',
                  width: 80,
                  height: 80,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'First',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Last',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                '$username',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildClickableContainer(
                      'Orders',
                      'Check Order Details',
                          () => _navigateToOrdersPage(context),
                    ),
                    SizedBox(height: 10),
                    _buildClickableContainer(
                      'Account',
                      'Manage Account Settings',
                          () => _navigateToAccountSettings(context),
                    ),
                    SizedBox(height: 10),
                    _buildClickableContainer(
                      'Settings',
                      'Manage General Settings',
                          () => _navigateToGeneralSettings(context),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(bottom: 180), // Add bottom padding
                child: ElevatedButton(
                  onPressed: () => _handleLogout(context),
                  child: Text(
                    'Logout',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Color(0xFF273140),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
