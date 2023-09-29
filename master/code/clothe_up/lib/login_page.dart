import 'package:flutter/material.dart';
import 'profile_page.dart'; // Import the profile_page.dart file
import 'organization_page.dart';
import 'catalog_page.dart';
import 'user_data.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isValidUser() {
    String enteredUsername = _usernameController.text;
    String enteredPassword = _passwordController.text;

    UserData? user = usersData.firstWhere(
          (user) =>
      user.username == enteredUsername &&
          user.password == enteredPassword &&
          !user.isOrg,
      orElse: () => UserData(
        firstName: '',
        lastName: '',
        username: '',
        password: '',
        isOrg: false,
      ),
    );

    return user.username.isNotEmpty;
  }

  bool _isValidOrg() {
    String enteredUsername = _usernameController.text;
    String enteredPassword = _passwordController.text;

    UserData? user = usersData.firstWhere(
          (user) =>
      user.username == enteredUsername &&
          user.password == enteredPassword &&
          user.isOrg,
      orElse: () => UserData(
        firstName: '',
        lastName: '',
        username: '',
        password: '',
        isOrg: false,
      ),
    );

    return user.username.isNotEmpty;
  }

  void _login() {
    if (_isValidOrg()) {
      Navigator.pushNamed(
        context,
        OrganizationPage.routeName,
        arguments: {'username': _usernameController.text},
      );
    } else if (_isValidUser()) {
      // Navigate to the profile page with username passed as arguments
      Navigator.pushNamed(
        context,
        CatalogPage.routeName,
        arguments: {'username': _usernameController.text},
      );
    } else {
      // Show an error message or perform appropriate actions
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Credentials'),
            content: Text('Please enter valid username and password.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color(0xFF273140),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              // Add the ClotheUp logo above the profile icon
              Image.asset(
                '/Users/akshay/clothe_up/lib/assets/images/clotheuplogo.png',
                width: 240,
                height: 160,
              ),
              SizedBox(height: 30),
              Image.asset(
                '/Users/akshay/clothe_up/lib/assets/images/profile_icon.png',
                width: 80,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController, // Add the controller
                style: TextStyle(color: Color(0xFF273140)),
                decoration: InputDecoration(
                  labelText: 'Username',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController, // Add the controller
                style: TextStyle(color: Color(0xFF273140)),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // Add your logic for forgot password
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text(
                  'SIGN IN',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: _login, // Call the login function
              ),
              SizedBox(height: 10),
              Text(
                'Or',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // Add your logic for the first logo button
                    },
                    child: Image.asset(
                      '/Users/akshay/clothe_up/lib/assets/images/facebook_logo.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      // Add your logic for the second logo button
                    },
                    child: Image.asset(
                      '/Users/akshay/clothe_up/lib/assets/images/google_logo.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      // Add your logic for the third logo button
                    },
                    child: Image.asset(
                      '/Users/akshay/clothe_up/lib/assets/images/apple_logo.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 1),
                  TextButton(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Color(0xFFFC6828)),
                    ),
                    onPressed: () {
                      // Add your logic for sign up
                    },
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
