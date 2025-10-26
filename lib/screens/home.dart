import 'package:flutter/material.dart';
import 'package:storekeeper/data/dummy_data.dart';
import 'package:storekeeper/widgets/product_tile.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StoreKeeper App',style: Theme.of(context).textTheme.titleLarge,),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ...products.map((product) {
              return ProductTile(title: product.name,price: product.price,quantity: product.quantity,bgImage: product.image,);
            })
          ],
        ),
      ),
    );
  }
}