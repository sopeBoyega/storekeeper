import 'dart:io';
import "package:uuid/uuid.dart";

var uuid = Uuid();


class Product {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final File? image;

  Product({
    String? id,
    this.image, 
    required this.name,
    required this.quantity,
    required this.price,
  }): id = id ?? uuid.v4() ;
}
