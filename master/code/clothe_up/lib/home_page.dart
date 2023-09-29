import 'package:flutter/material.dart';
import 'login_page.dart'; // Import the login_page.dart file

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(
                '/Users/akshay/clothe_up/lib/assets/images/clotheuplogo.png',
                width: 350,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Unite, share, and make a difference through clothing',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Helvetica',
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: ElevatedButton(
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
