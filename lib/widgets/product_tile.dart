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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
        Theme.of(context).colorScheme.surface,
        Theme.of(context).colorScheme.primary.withValues(alpha: 0.04),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
        color: Colors.black.withValues(alpha :0.08),
        blurRadius: 8,
        offset: const Offset(0, 4),
        ),
      ],
      border: Border.all(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha:  0.5),
      ),
      ),
      child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        radius: 26,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        backgroundImage: bgImage != null ? FileImage(bgImage!) : null,
        child: bgImage == null
          ? Icon(
            Icons.inventory_2_outlined,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          )
          : null,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w600,
          ),
      ),
      subtitle: Text(
        "$quantity items in stock",
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
          ),
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
        Text(
          "₦${price.toStringAsFixed(2)}",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
          "$quantity",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ],
      ),
      ),
    );
  }
}
