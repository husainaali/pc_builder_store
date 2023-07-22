import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pc_builder_store/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class PhotoViewerSlider extends StatefulWidget {
  final List<PhotoData> photos;

  const PhotoViewerSlider({Key? key, required this.photos}) : super(key: key);

  @override
  _PhotoViewerSliderState createState() => _PhotoViewerSliderState();
}

class _PhotoViewerSliderState extends State<PhotoViewerSlider> {
  List<Product> _selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: widget.photos.asMap().entries.map((entry) {
        int index = entry.key;
        PhotoData photo = entry.value;

        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () async {
                int selectedCategoryNumber = photo.categoryNumber;
                List<Product> categoryProducts =
                    await loadProductsFromJson(context, 'products.json',
                        categoryNumber: selectedCategoryNumber);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pop-up Window'),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              child: Column(
                                children: categoryProducts.map((product) {
                                  return CheckboxListTile(
                                    value: _selectedProducts.contains(product),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value == true) {
                                          _selectedProducts.add(product);
                                        } else {
                                          _selectedProducts.remove(product);
                                        }
                                      });
                                    },
                                    title: ListTile(
                                      leading: Image.asset(
                                        product.imageUrl,
                                        width: 50.0,
                                        height: 50.0,
                                      ),
                                      title: Text(product.name),
                                      subtitle: Text(
                                        'Category: ${product.categoryNumber}\nPrice: \BHD ${double.parse(product.price).toStringAsFixed(2)}',
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () async {
                            await _addToCart(_selectedProducts);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Add to Cart'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(photo.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                      child: Text(
                        photo.price,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                      child: Text(
                        photo.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        enlargeCenterPage: true,
        viewportFraction: 0.4,
        aspectRatio: 16 / 9,
      ),
    );
  }

  // Load products from JSON file based on the category number
  Future<List<Product>> loadProductsFromJson(BuildContext context,
      String jsonFilePath, {
        int? categoryNumber,
      }) async {
    final jsonStr = await DefaultAssetBundle.of(context).loadString(jsonFilePath);
    final jsonData = json.decode(jsonStr);

    List<Product> products = [];
    for (var item in jsonData) {
      final product = Product(
        imageUrl: item['image_url'],
        price: item['price'], // Store the price as a string
        name: item['name'],
        categoryNumber: item['category_number'],
        id: item['id'],
      );

      if (categoryNumber == null || product.categoryNumber == categoryNumber) {
        products.add(product);
      }
    }

    return products;
  }

  // Store the selected products in the cart
  Future<void> _addToCart(List<Product> selectedProducts) async {
    final dbHelper = DatabaseHelper();
    for (var product in selectedProducts) {
      await dbHelper.insertProduct(product.id);
    }
  }
}

class PhotoData {
  final String imageUrl;
  final String price;
  final String name;
  final int categoryNumber;

  PhotoData({
    required this.imageUrl,
    required this.price,
    required this.name,
    required this.categoryNumber,
  });

  factory PhotoData.fromJson(Map<String, dynamic> json) {
    return PhotoData(
      imageUrl: json['imageUrl'],
      price: json['price'],
      name: json['name'],
      categoryNumber: json['category_number'],
    );
  }
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
