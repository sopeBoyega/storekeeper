import 'dart:io';


import 'package:flutter_riverpod/legacy.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart ' as sql;
import 'package:sqflite/sqflite.dart';
// import 'package:storekeeper/data/dummy_data.dart';
import 'package:storekeeper/models/item.dart';

// Images were ssave locally on the system to the app's directory so they could persist
// The following packagegs were used sqflite,path,path_provider to facilitate the whole process

class ProductsProvider extends StateNotifier<List<Product>> {
  ProductsProvider() : super([]);

  Future<List<Product>> loadProducts() async {
    sql.Database db = await loadDB();
    final data = await db.query('products_inventory');
    final products = data.map((row) {
      return Product(
        id: row['id'] as String,
        name: row['name'] as String,
        image: File(row['image'] as String),
        price: row['price'] as double,
        quantity: row['quantity'] as int,
      );
    }).toList();

    state = products;
    return state;
  }

  Future<void> addNewProduct(
    String name,
    File? image,
    int quantity,
    double price,
  ) async {
    Product product;

    if (image != null) {
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final filename = path.basename(image.path);
      final copiedImage = await image.copy("${appDir.path}/$filename");

      product = Product(
        name: name,
        quantity: quantity,
        price: price,
        image: copiedImage,
      );
    } else {
      product = Product(name: name, quantity: quantity, price: price);
    }
    sql.Database db = await loadDB();

    await db.insert("products_inventory", {
      'id': product.id,
      'name': product.name,
      'image': product.image?.path,
      'price': product.price,
      'quantity': product.quantity,
    });

    state = [...state, product];
  }

  Future<void> editProduct(Product oldProduct, Product newProduct) async {

    Product finalProduct = newProduct;
    if (newProduct.image != null && newProduct.image?.path != oldProduct.image?.path) {
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final filename = path.basename(newProduct.image!.path);
      final copiedImage = await newProduct.image!.copy("${appDir.path}/$filename");
      
      finalProduct = Product(
        id: newProduct.id,
        name: newProduct.name,
        quantity: newProduct.quantity,
        price: newProduct.price,
        image: copiedImage,
      );
    }

    final db = await loadDB();
    await db.update(
      'products_inventory',
      {
        'id': finalProduct.id,
        'name': finalProduct.name,
        'image': finalProduct.image?.path,
        'price': finalProduct.price,
        'quantity': finalProduct.quantity,
      },
      where: 'id = ?',
      whereArgs: [oldProduct.id],
    );

    final index = state.indexWhere((p) => p.id == oldProduct.id);
    if (index >= 0) {
      final updated = [...state];
      updated[index] = finalProduct;
      state = updated;
    }
  }

  Future<void> removeProduct(Product product) async {
    final db = await loadDB();

    await db.delete(
      'products_inventory',
      where: 'id = ?',
      whereArgs: [product.id],
    );

    state = state.where((p) => p.id != product.id).toList();
  }

  Future<Database> loadDB() async {
    // Get the db path
    final dbPath = await sql.getDatabasesPath();
    // Intialize the local database an create a schema
    final db = await sql.openDatabase(
      path.join(dbPath,'products_inventory.db'),
      onCreate: (db, version) {
        print("Creating products_inventory table...");
        return db.execute(
          'CREATE TABLE products_inventory(id TEXT PRIMARY KEY, name TEXT, image TEXT, quantity INTEGER, price REAL)',
        );
      },
      version: 5,
    );
    return db;
  }
}

final productsProvider = StateNotifierProvider<ProductsProvider, List<Product>>(
  (ref) {
    return ProductsProvider();
  },
);
