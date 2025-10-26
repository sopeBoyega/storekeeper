import 'dart:io';

class Product {
  
 final String name;
 final int quantity;
 final double price;
 final File? image;


 Product({
  required this.name,
  required this.quantity,
  required this.price,
  this.image
 });
 
}