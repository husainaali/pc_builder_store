import 'dart:convert';
import 'package:flutter/material.dart';

import 'photo_viewer_slider.dart'; // Import the Product model from the cart_page.dart file
Future<List<Product>> loadProductsFromJson(
  BuildContext context,
  String jsonFilePath, {
  int? categoryNumber,
}) async {
  final jsonStr = await DefaultAssetBundle.of(context).loadString(jsonFilePath);
  final jsonData = json.decode(jsonStr);

  List<Product> products = [];
  for (var item in jsonData) {
    final product = Product(
      id: item['id'], // Assuming 'id' is an integer in the JSON data
      imageUrl: item['image_url'],
      price: item['price'], // Store the price as a string
      name: item['name'],
      categoryNumber: int.parse(item['category_number']), // Parse to an integer
    );

    if (categoryNumber == null || product.categoryNumber == categoryNumber) {
      products.add(product);
    }
  }

  return products;
}

class Product {
  final int id;
  final String imageUrl;
  final String price;
  final String name;
  final int categoryNumber;

  Product({
    required this.id,
    required this.imageUrl,
    required this.price,
    required this.name,
    required this.categoryNumber,
  });
}
