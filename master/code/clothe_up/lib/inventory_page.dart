import 'package:flutter/material.dart';
import 'product.dart';

class InventoryPage extends StatefulWidget {
  final List<Product> products;
  final Product newProduct;

  InventoryPage({required this.products, required this.newProduct});

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  void initState() {
    super.initState();
    if (widget.newProduct.imageUrl.trim().isNotEmpty) {
      widget.products.add(widget.newProduct);
    }
  }

  void _deleteProduct(int index) {
    setState(() {
      widget.products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
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
        child: ListView.builder(
          itemCount: widget.products.length,
          itemBuilder: (context, index) {
            final product = widget.products[index];
            Widget leadingImage;

            // Check if the image is a local asset or a network image
            if (product.imageUrl.startsWith('/')) {
              leadingImage = Image.asset(
                product.imageUrl,
                width: 48,
                height: 48,
              );
            } else {
              leadingImage = Image.network(
                product.imageUrl,
                width: 48,
                height: 48,
              );
            }

            return Card(
              color: Colors.white,
              elevation: 2,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: leadingImage,
                title: Text(
                  product.productName,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Size: ${product.size}',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      'Gender: ${product.gender}',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      'Product Type: ${product.productType}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteProduct(index),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
