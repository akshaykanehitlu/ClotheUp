import 'package:flutter/material.dart';

class Product {
  final String productName;
  final String imageUrl;
  final String size;
  final String gender;
  final String productType;

  Product({
    required this.productName,
    required this.size,
    required this.gender,
    required this.imageUrl,
    required this.productType,
  });

  Widget getImageWidget() {
    return Image.asset(
      imageUrl,
      width: 48,
      height: 48,
    );
  }
}

final List<Product> products = [
  Product(
    productName: 'Winter Jacket',
    size: 'M',
    gender: 'Male',
    imageUrl: '/Users/akshay/clothe_up/lib/assets/images/Winterjacket.png',
    productType: 'Outerwear',
  ),
  Product(
    productName: 'Raincoat',
    size: 'M',
    gender: 'Male',
    imageUrl: '/Users/akshay/clothe_up/lib/assets/images/Raincoat.png',
    productType: 'Outerwear',
  ),
  Product(
    productName: 'Windbreaker',
    size: 'M',
    gender: 'Male',
    imageUrl: '/Users/akshay/clothe_up/lib/assets/images/Windbreaker.png',
    productType: 'Outerwear',
  ),
  Product(
    productName: 'Parka',
    size: 'M',
    gender: 'Female',
    imageUrl: '/Users/akshay/clothe_up/lib/assets/images/Parka.png',
    productType: 'Outerwear',
  ),
  Product(
    productName: 'Sweater',
    size: 'M',
    gender: 'Female',
    imageUrl: '/Users/akshay/clothe_up/lib/assets/images/Sweater.png',
    productType: 'Outerwear',
  ),
  Product(
    productName: 'Hoodie',
    size: 'M',
    gender: 'Female',
    imageUrl: '/Users/akshay/clothe_up/lib/assets/images/Hoodie.png',
    productType: 'Outerwear',
  ),
  // Add more products here
];
