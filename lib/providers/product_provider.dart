import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
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

  void  removeProduct(Product product){
    final _productItem = state.indexOf(product);

    state.remove(product);
  }
}

final productsProvider = StateNotifierProvider<ProductsProvider, List<Product>>(
  (ref) {
    return ProductsProvider();
  },
);
