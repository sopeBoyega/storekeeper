import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:storekeeper/data/dummy_data.dart';
import 'package:storekeeper/providers/product_provider.dart';
import 'package:storekeeper/screens/new_product.dart';
import 'package:storekeeper/screens/product_details.dart';
import 'package:storekeeper/widgets/product_tile.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load products when the screen initializes
    ref.read(productsProvider.notifier).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    // Watch both the products list and any loading state
    final products = ref.watch(productsProvider);
    final removeProduct = ref.read(productsProvider.notifier).removeProduct;
    return Scaffold(
      appBar: AppBar(
        title: Text('Products', style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => NewProductScreen()),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: products.isEmpty
          ? const Center(
              child: Text(
                textAlign: TextAlign.center,
                "Uh ohh.., You have no items in your list, Click the plus button to add items",
              ),
            )
          : Center(
            child: ListView.builder(
              itemCount: products.length,
              // mainAxisAlignment: MainAxisAlignment.start,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => ProductDetails(product: product),
                      ),
                    );
                  },
                  child: Dismissible(
                    key: ValueKey(product.id),
                    onDismissed: (direction) {
                      removeProduct(product);
                    },
                    child: ProductTile(
                      title: product.name,
                      price: product.price,
                      quantity: product.quantity,
                      bgImage: product.image,
                    ),
                  ),
                );
              },
            ),
          )
    );
        }
  }

