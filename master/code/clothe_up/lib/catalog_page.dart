import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'product_details_page.dart';
import 'cart_page.dart';

class CatalogPage extends StatelessWidget {
  static const String routeName = '/catalog';

  final List<Map<String, String>> clothingItems = [
    {
      'title': 'Winter Jacket',
      'assetName': 'assets/images/Winterjacket.png',
    },
    {
      'title': 'Raincoat',
      'assetName': 'assets/images/Raincoat.png',
    },
    {
      'title': 'Windbreaker',
      'assetName': 'assets/images/Windbreaker.png',
    },
    {
      'title': 'Parka',
      'assetName': 'assets/images/Parka.png',
    },
    {
      'title': 'Sweater',
      'assetName': 'assets/images/Sweater.png',
    },
    {
      'title': 'Hoodie',
      'assetName': 'assets/images/Hoodie.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Catalog', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Get the current username from wherever it's stored (e.g., from the login process)
              String username = 'username'; // Replace 'username' with the actual username

              Navigator.pushNamed(
                context,
                ProfilePage.routeName,
                arguments: {'username': username},
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, CartPage.routeName); // Navigate to the cart page
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF273140),
              Color(0xFF19212A), // Darker color for gradient
            ],
          ),
        ),
        padding: EdgeInsets.only(top: 40, left: 20, right: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8, // Adjust aspect ratio for better image representation
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: clothingItems.length,
          itemBuilder: (context, index) {
            return buildCatalogItem(
              context,
              title: clothingItems[index]['title']!,
              assetName: clothingItems[index]['assetName']!,
            );
          },
        ),
      ),
    );
  }

  Widget buildCatalogItem(BuildContext context, {required String title, required String assetName}) {
    return GestureDetector(
      onTap: () {
        // Navigate to the product details page when the image is tapped
        Navigator.pushNamed(
          context,
          ProductDetailsPage.routeName,
          arguments: {
            'title': title,
            'assetName': assetName,
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4)],
            ),
            child: Image.asset(
              assetName,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
