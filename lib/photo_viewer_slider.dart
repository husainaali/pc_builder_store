import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PhotoViewerSlider extends StatelessWidget {
  final List<PhotoData> photos;

  const PhotoViewerSlider({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CarouselSlider(
        items: photos.map((photo) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () async {
                  List<Product> products =
                      await loadProductsFromJson(context, 'products.json');

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Pop-up Window'),
                        content: SizedBox(
                          height: 200.0,
                          child: ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (BuildContext context, int index) {
                              Product product = products[index];
                              return ListTile(
                                leading: Image.asset(
                                  product.imageUrl,
                                  width: 50.0,
                                  height: 50.0,
                                ),
                                title: Text(product.name),
                                subtitle: Text(
                                    'Category: ${product.categoryNumber}\nPrice: \$${product.price.toStringAsFixed(2)}'),
                              );
                            },
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              // Perform the "Add to Cart" action here
                              // You can access the selected products from the 'products' list
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
          viewportFraction: 0.4, // Adjust the value as needed
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}

class PhotoData {
  final String imageUrl;
  final String price;
  final String name;

  PhotoData({
    required this.imageUrl,
    required this.price,
    required this.name,
  });

  factory PhotoData.fromJson(Map<String, dynamic> json) {
    return PhotoData(
      imageUrl: json['imageUrl'],
      price: json['price'],
      name: json['name'],
    );
  }
}

class Product {
  final String name;
  final int categoryNumber;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.categoryNumber,
    required this.price,
    required this.imageUrl,
  });
}

Future<List<Product>> loadProductsFromJson(
    BuildContext context, String jsonFilePath) async {
  final jsonStr = await DefaultAssetBundle.of(context).loadString(jsonFilePath);
  final jsonData = json.decode(jsonStr);

  List<Product> products = [];
  for (var item in jsonData) {
    products.add(Product(
      imageUrl: item['image_url'],
      price: item['price'].toDouble(),
      name: item['name'],
      categoryNumber: item['category_number'],
    ));
    print(item['image_url']);
  }

  return products;
}
