import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_page.dart';
import 'cart_page.dart';
import 'cart_item.dart';
import 'cart_model.dart';

class ProductDetailsPage extends StatefulWidget {
  final String title;
  final String assetName;

  static const String routeName = '/productDetails';

  ProductDetailsPage({required this.title, required this.assetName});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String selectedSize = '';
  bool showAddedToCartMessage = false;

  @override
  Widget build(BuildContext context) {
    var cartModel = Provider.of<CartModel>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0xFF273140),
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
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
              Navigator.pushNamed(context, CartPage.routeName);
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.white,
                    child: Image.asset(
                      widget.assetName,
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${widget.title}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF393F48),
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildPickupLocationCard(),
                  SizedBox(height: 16),
                  Text(
                    'Size',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF393F48),
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildSizeButtons(),
                ],
              ),
            ),
          ),
          if (showAddedToCartMessage)
            Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Added to cart!',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 56.0),
        child: FloatingActionButton(
          onPressed: selectedSize.isEmpty
              ? () {
            _showSelectSizeDialog(context);
          }
              : () {
            _addToCart(context);
          },
          backgroundColor: Color(0xFF292D32),
          child: Icon(Icons.add_shopping_cart, color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(height: 0),
      ),
    );
  }

  void _showSelectSizeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Size'),
          content: Text('Please select a size before adding to cart.'),
          actions: <Widget>[
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

  void _addToCart(BuildContext context) {
    if (selectedSize.isEmpty) {
      _showSelectSizeDialog(context);
    } else {
      var cartItem = CartItem(
        title: widget.title,
        assetName: widget.assetName,
        size: selectedSize,
        quantity: 1,
      );
      var cartModel = Provider.of<CartModel>(context, listen: false);
      cartModel.addToCart(cartItem);
      setState(() {
        showAddedToCartMessage = true;
      });
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          showAddedToCartMessage = false;
        });
      });
    }
  }

  Widget _buildPickupLocationCard() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 380,
        child: Card(
          elevation: 2,
          color: Color(0xFFEEF1F4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Available for pickup at location X',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSizeButtons() {
    List<String> sizes = ['XS', 'S', 'M', 'L', 'XL'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: sizes.map((size) {
        bool isSelected = selectedSize == size;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
            onPressed: () {
              _updateSelectedSize(size);
            },
            style: ElevatedButton.styleFrom(
              primary: isSelected ? Colors.black : Colors.white,
              onPrimary: isSelected ? Colors.white : Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(
                  color: isSelected ? Colors.black : Colors.white,
                  width: 2.0,
                ),
              ),
            ),
            child: Text(size),
          ),
        );
      }).toList(),
    );
  }

  void _updateSelectedSize(String newSize) {
    setState(() {
      selectedSize = newSize;
    });
  }
}
