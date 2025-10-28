import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storekeeper/models/item.dart';
import 'package:storekeeper/providers/product_provider.dart';
import 'package:storekeeper/screens/edit_page.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductDetails extends ConsumerWidget {
  const ProductDetails({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final products = ref.watch(productsProvider);
    final currentProduct = products.firstWhere(
      (p) => p.id == product.id,
      orElse: () => product, 
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(currentProduct.name, style: Theme.of(context).textTheme.titleMedium,),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => EditProductScreen(product: currentProduct),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              margin: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.hardEdge,
              child: Hero(
                tag: currentProduct.id, 
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: currentProduct.image != null 
                      ? FileImage(currentProduct.image!) 
                      : const AssetImage('assets/img.png') as ImageProvider,
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
            ),
            Text(
              currentProduct.name,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "₦${currentProduct.price.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "${currentProduct.quantity} items left in stock",
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