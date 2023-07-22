import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Product {
  final int id;
  final String imageUrl;
  final double price;
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

class GridViewPage extends StatefulWidget {
  @override
  _GridViewPageState createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    loadProductsFromJson();
  }

  Future<void> loadProductsFromJson() async {
    String jsonProducts = await rootBundle.loadString('assets/products.json');

    List<dynamic> jsonData = json.decode(jsonProducts);
    List<Product> loadedProducts = [];

    for (var item in jsonData) {
      loadedProducts.add(Product(
        id: item['id'],
        imageUrl: item['image_url'],
        price: double.parse(item['price']),
        name: item['name'],
        categoryNumber: item['category_number'],
      ));
    }

    setState(() {
      products = loadedProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 2 / 3,
          height: MediaQuery.of(context).size.height * 1.7 / 3,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              Product product = products[index];
              return Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      product.imageUrl,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                    Text(
                      product.name,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "\BHD ${product.price}",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),

                                      ElevatedButton(
                    onPressed: () {
                      // Add logic for handling the checkout process here
                      // For example, you can navigate to a confirmation page.
                    },
                    child: Text('Add to Cart'),
                  ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GridViewPage(),
  ));
}
