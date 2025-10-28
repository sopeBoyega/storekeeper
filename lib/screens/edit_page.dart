import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storekeeper/models/item.dart';
import 'package:storekeeper/providers/product_provider.dart';
import 'package:storekeeper/screens/home.dart';
import 'package:storekeeper/widgets/image_input.dart';

class EditProductScreen extends ConsumerStatefulWidget {
  const EditProductScreen({super.key, required this.product});


  final Product product;
  @override
  ConsumerState<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends ConsumerState<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  
  
  var _enteredTitle = "";
  var _productPrice = "";
  var _productQuantity = "";

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    // If the product already has an image, use it as the initial selection
    _selectedImage = widget.product.image;
  }

  void _editProduct() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    // if (_selectedImage == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Please add a product image')),
    //   );
    //   return;
    // }

    debugPrint('Title: $_enteredTitle');
    debugPrint('Price: $_productPrice');
    debugPrint('Quantity: $_productQuantity');
    debugPrint('Image: ${_selectedImage != null ? _selectedImage!.path : 'No image selected'}');

    final newProduct  = _selectedImage != null ? Product(name: _enteredTitle, quantity:int.parse(_productQuantity), price: double.parse(_productPrice)) : Product(name: _enteredTitle, quantity:int.parse(_productQuantity), price: double.parse(_productPrice),image: _selectedImage);

    ref.read(productsProvider.notifier).editProduct(widget.product,newProduct);

    Navigator.push(context,MaterialPageRoute(builder: (ctx) => HomeScreen()));
  }

  String? _validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter a name';
    if (value.trim().length > 50) return 'Name too long (max 50)';
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter a price';
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || parsed < 0) return 'Enter a valid price';
    return null;
  }

  String? _validateQuantity(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter a quantity';
    final parsed = int.tryParse(value);
    if (parsed == null || parsed < 0) return 'Enter a valid quantity';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product', style: theme.textTheme.titleMedium),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image preview and the picker,abeg work
                    const SizedBox(height: 12),
                    ImageInput(
                      initialImage: product.image,
                      onSelectImage: (image) {
                        setState(() {
                          _selectedImage = image;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Title
                    TextFormField(
                      initialValue: product.name,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: _validateTitle,
                      onSaved: (v) => _enteredTitle = v!.trim(),
                    ),
                    const SizedBox(height: 12),

                    // Price & Quantity in a row
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            initialValue: product.price.toString(),
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: false, decimal: true),
                            decoration: const InputDecoration(
                              prefixText: '₦ ',
                              labelText: 'Price',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 14),
                            ),
                            validator: _validatePrice,
                            onSaved: (v) => _productPrice = v!.trim(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            initialValue: product.quantity.toString(),
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: false, decimal: false),
                            decoration: const InputDecoration(
                              labelText: 'Qty',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 14),
                            ),
                            validator: _validateQuantity,
                            onSaved: (v) => _productQuantity = v!.trim(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _editProduct,
                            icon: const Icon(Icons.add),
                            label: const Text('Edit'),
                            style: ElevatedButton.styleFrom(
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
