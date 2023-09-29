import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'organization_page.dart';
import 'catalog_page.dart';
import 'product_details_page.dart';
import 'cart_page.dart';
import 'cart_model.dart';

void main() {
  runApp(ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MaterialApp(
        title: 'ClotheUp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color(0xFF273140),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(key: Key('homePage')),
          LoginPage.routeName: (context) => LoginPage(key: Key('loginPage')),
          ProfilePage.routeName: (context) => ProfilePage(username: ''),
          ProductDetailsPage.routeName: (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
            return ProductDetailsPage(
              title: args['title']!,
              assetName: args['assetName']!,
            );
          },
          CatalogPage.routeName: (context) => CatalogPage(),
          OrganizationPage.routeName: (context) => OrganizationPage(),
          CartPage.routeName: (context) => CartPage(), // Pass the cartItems list to CartPage
        },
      ),
    );
  }
}
