import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart ' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:storekeeper/data/dummy_data.dart';
import 'package:storekeeper/models/item.dart';

class ProductsProvider extends StateNotifier<List<Product>> {
  ProductsProvider() : super(products);

  void addNewProduct(String name, File? image, int quantity, double price) {
    final product = image != null
        ? Product(name: name, quantity: quantity, price: price, image: image)
        : Product(name: name, quantity: quantity, price: price);
    
    
    state = [...state, product];
  }

  void editProduct(Product oldProduct,Product newProduct){
     final index = state.indexOf(oldProduct);
     
     removeProduct(oldProduct);

     state.insert(index, newProduct);

  }

  void  removeProduct(Product product){
    state.remove(product);
  }

   Future<Database> loadDB() async {
    // Get the db path
    final dbPath = await sql.getDatabasesPath();
    // Intialize the local database an create a schema
    final db = await sql.openDatabase(
      path.join(dbPath, 'products'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, long REAL, address TEXT)',
        );
      },
      version: 2,
    );
    return db;
  }
}

final productsProvider = StateNotifierProvider<ProductsProvider, List<Product>>(
  (ref) {
    return ProductsProvider();              
  },
);
