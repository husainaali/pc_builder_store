import 'package:sqflite/sqflite.dart';


import 'package:path/path.dart'; // Add this line for the path package

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static DatabaseHelper get instance => _instance; // Add this getter

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'cart.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart (
            id INTEGER PRIMARY KEY
          )
        ''');
      },
    );
  }

  Future<void> insertProduct(int productId) async {
    final db = await database;
    await db.insert('cart', {'id': productId});
  }

  Future<List<int>> getCartProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart');
    return List.generate(maps.length, (i) => maps[i]['id']);
  }

  Future<List<Product>> getAllProducts() async {
    // Fetch all products from the database and return them
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) {
      return Product(
        id: maps[i]['id'],
        imageUrl: maps[i]['imageUrl'],
        price: maps[i]['price'],
        name: maps[i]['name'],
        categoryNumber: maps[i]['categoryNumber'],
      );
    });
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
