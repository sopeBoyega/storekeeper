import 'package:flutter/material.dart';
import 'package:storekeeper/models/item.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});


  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name,style: Theme.of(context).textTheme.titleMedium,),

      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              margin: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.hardEdge,
              child: Hero(
                tag: product.name,
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  // NetworkImage class helps load images from the internet
                    image: NetworkImage('https://via.placeholder.com/600x200.png?text=No+Image'),
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
            ),
            Text(
            product.name,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
            SizedBox(height: 10,),
            Text(
            "₦${product.price.toStringAsFixed(2)}",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
           SizedBox(height: 10,),
            Text(
            "${product.quantity} items left in stock",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          ],
        ),
      ),
    );
  }
}