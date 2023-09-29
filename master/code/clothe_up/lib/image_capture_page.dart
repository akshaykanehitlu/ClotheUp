import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'inventory_page.dart';
import 'product.dart';

class ImageCapturePage extends StatefulWidget {
  @override
  _ImageCapturePageState createState() => _ImageCapturePageState();
}

class _ImageCapturePageState extends State<ImageCapturePage> {
  File? _imageFile;
  String? _gender;
  String? _size;
  String? _type;
  String? _productName;

  Future<void> _openCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? capturedImage =
    await _picker.pickImage(source: ImageSource.gallery); // Change to ImageSource.gallery

    if (capturedImage != null) {
      setState(() {
        _imageFile = File(capturedImage.path);
      });
    }
  }

  void _selectGender(String? value) {
    setState(() {
      _gender = value;
    });
  }

  void _selectSize(String? value) {
    setState(() {
      _size = value;
    });
  }

  void _selectType(String? value) {
    setState(() {
      _type = value;
    });
  }

  void _onProductNameChanged(String value) {
    setState(() {
      _productName = value;
    });
  }

  void _submitDetails() {
    if (_productName == null || _productName!.isEmpty) {
      _showErrorDialog('Product Name');
      return;
    }

    if (_gender == null || _gender!.isEmpty) {
      _showErrorDialog('Gender');
      return;
    }

    if (_size == null || _size!.isEmpty) {
      _showErrorDialog('Size');
      return;
    }

    if (_type == null || _type!.isEmpty) {
      _showErrorDialog('Type');
      return;
    }

    String defaultImagePath = '/Users/akshay/clothe_up/lib/assets/images/mannequinimage.jpeg';

    // If no image is uploaded, use the default image path
    String imagePath = _imageFile?.path ?? defaultImagePath;
    if (_imageFile != null) {
      print('Image Path: ${_imageFile!.path}');
    }

    // Create a new Product based on the selected details
    Product newProduct = Product(
      productName: _productName!, // Product name is mandatory, so it should not be null or empty
      size: _size!,
      gender: _gender!,
      imageUrl: imagePath, // Use the image path if available
      productType: _type!,
    );

    products.add(newProduct);

    // Show "Product added successfully!" dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Product added successfully!'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    // Navigate to the InventoryPage and pass the newProduct as arguments
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => InventoryPage(products: products, newProduct: newProduct),
    //   ),
    // );
  }

  void _showErrorDialog(String missingDetail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Please select $missingDetail.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: Color(0xFF262A3F),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _openCamera,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: _imageFile != null
                        ? kIsWeb // Check if the platform is web
                        ? Image.network(_imageFile!.path, width: 180, height: 180)
                        : Image.file(_imageFile!, width: 180, height: 180)
                        : Icon(
                      Icons.photo_camera,
                      size: 100,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'Product Name:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onChanged: _onProductNameChanged,
                        decoration: InputDecoration(
                          hintText: 'Enter product name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: 350,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectGender('Male'),
                        style: ElevatedButton.styleFrom(
                          primary: _gender == 'Male' ? Color(0xFF393F48) : Colors.grey,
                        ),
                        child: Text(
                          'Male',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectGender('Female'),
                        style: ElevatedButton.styleFrom(
                          primary: _gender == 'Female' ? Color(0xFF393F48) : Colors.grey,
                        ),
                        child: Text(
                          'Female',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: 350,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectSize('S'),
                        style: ElevatedButton.styleFrom(
                          primary: _size == 'S' ? Color(0xFF393F48) : Colors.grey,
                        ),
                        child: Text(
                          'S',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectSize('M'),
                        style: ElevatedButton.styleFrom(
                          primary: _size == 'M' ? Color(0xFF393F48) : Colors.grey,
                        ),
                        child: Text(
                          'M',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectSize('L'),
                        style: ElevatedButton.styleFrom(
                          primary: _size == 'L' ? Color(0xFF393F48) : Colors.grey,
                        ),
                        child: Text(
                          'L',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectSize('XL'),
                        style: ElevatedButton.styleFrom(
                          primary: _size == 'XL' ? Color(0xFF393F48) : Colors.grey,
                        ),
                        child: Text(
                          'XL',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: 350,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectType('Top'),
                        style: ElevatedButton.styleFrom(
                          primary: _type == 'Top' ? Color(0xFF393F48) : Colors.grey,
                        ),
                        child: Text(
                          'Top',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectType('Bottom'),
                        style: ElevatedButton.styleFrom(
                          primary: _type == 'Bottom' ? Color(0xFF393F48) : Colors.grey,
                        ),
                        child: Text(
                          'Bottom',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectType('Outerwear'),
                        style: ElevatedButton.styleFrom(
                          primary: _type == 'Outerwear' ? Color(0xFF393F48) : Colors.grey,
                        ),
                        child: Text(
                          'Outerwear',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitDetails,
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF393F48),
                ),
                child: Text(
                  'Add to Inventory',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
