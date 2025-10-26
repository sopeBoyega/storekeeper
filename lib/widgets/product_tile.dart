import 'dart:io';

import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.title,
    required this.bgImage,
    required this.quantity,
    required this.price,
  });

  final String title;
  final File? bgImage;
  final int quantity;
  final double price;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(radius: 26, backgroundColor: Colors.black,),
       title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          subtitle: Text(
            "$quantity items in stock",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          trailing: Text(
            "₦${price.toStringAsFixed(2)}",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              
            ),
          ),
          onTap: () {
            
          },
    );
  }
}
