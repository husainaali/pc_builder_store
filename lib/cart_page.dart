import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

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

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Product> _selectedProducts = [];
  double _totalPrice = 0.0;
  double _vatAmount = 0.0;
  double _totalPriceWithVat = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateTotal();
  }

  Future<List<Product>> _loadProductsFromJson() async {
    // Load the products from the JSON file based on category 2
    List<Product> allProducts = await getAllProductsFromJson();
    List<Product> categoryProducts =
        allProducts.where((product) => product.categoryNumber == 2).toList();
    return categoryProducts;
  }

  Future<List<Product>> getAllProductsFromJson() async {
    String jsonProducts =
        await rootBundle.loadString('assets/products.json');
    List<dynamic> jsonData = json.decode(jsonProducts);

    List<Product> products = jsonData
        .map((item) => Product(
              id: item['id'],
              imageUrl: item['image_url'],
              price: item['price'],
              name: item['name'],
              categoryNumber: item['category_number'],
            ))
        .toList();

    return products;
  }

  void _calculateTotal() async {
    List<Product> categoryProducts = await _loadProductsFromJson();
    double totalPrice = 0;
    for (Product product in categoryProducts) {
      totalPrice += double.parse(product.price);
    }

    double vatAmount = totalPrice * 0.10;
    double totalPriceWithVat = totalPrice + vatAmount;

    setState(() {
      _totalPrice = totalPrice;
      _vatAmount = vatAmount;
      _totalPriceWithVat = totalPriceWithVat;
    });
  }

  Widget buildPriceSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Price Summary',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Total Price: \BHD ${_totalPrice.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          'VAT (10%): \BHD ${_vatAmount.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          'Total Price (incl. VAT): \BHD ${_totalPriceWithVat.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 181, 161, 103),

        title: Text('Cart')),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: FutureBuilder<List<Product>>(
                future: _loadProductsFromJson(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<Product> categoryProducts = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: categoryProducts.length,
                      itemBuilder: (context, index) {
                        final product = categoryProducts[index];
                        return ListTile(
                          leading: Image.asset(
                            product.imageUrl,
                            width: 50.0,
                            height: 50.0,
                          ),
                          title: Text(product.name),
                          subtitle: Text(
                            'Category: ${product.categoryNumber}\nPrice: \BHD ${double.parse(product.price).toStringAsFixed(2)}',
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildPriceSummary(), // Display the price summary
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Address Line 1'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Address Line 2'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'City'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'State'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Zip Code'),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Country'),
                  ),
                  SizedBox(height: 16),
                  DropdownButton<String>(
                    value: 'Credit Card',
                    items: ['Credit Card', 'PayPal', 'Bank Transfer']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      // Handle payment gateway selection
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add logic for handling the checkout process here
                      // For example, you can navigate to a confirmation page.
                    },
                    child: Text('Proceed to Checkout'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
