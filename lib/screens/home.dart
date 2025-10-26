import 'package:flutter/material.dart';
import 'package:storekeeper/data/dummy_data.dart';
import 'package:storekeeper/screens/new_product.dart';
import 'package:storekeeper/screens/product_details.dart';
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
        title: Text('Products',style: Theme.of(context).textTheme.titleLarge,),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (ctx) => NewProductScreen()));
          }, icon: Icon(Icons.add))
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: products.length,
          // mainAxisAlignment: MainAxisAlignment.start,
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (ctx) => ProductDetails(product: product)));
            },child: ProductTile(title: product.name,price: product.price,quantity: product.quantity,bgImage: product.image,),);
          },    
        ),
      ),
    );
  }
}