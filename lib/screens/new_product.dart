import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storekeeper/models/item.dart';
import 'package:storekeeper/providers/product_provider.dart';
import 'package:storekeeper/widgets/image_input.dart';

class NewProductScreen extends ConsumerStatefulWidget {
  const NewProductScreen({super.key});

  @override
  ConsumerState<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends ConsumerState<NewProductScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = "";
  var _productPrice = "";
  var _productQuantity = "";

  File? _selectedImage;

  void _savePlace() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add a product image')),
      );
      return;
    }

    // TODO: persist product using sqflite and riverpod
    debugPrint('Title: $_enteredTitle');
    debugPrint('Price: $_productPrice');
    debugPrint('Quantity: $_productQuantity');
    debugPrint('Image: ${_selectedImage!.path}');

    ref.read(productsProvider.notifier).addNewProduct(_enteredTitle,File(_selectedImage!.path),int.parse(_productQuantity) ,double.parse(_productPrice));

    Navigator.of(context).pop();
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
                      onSelectImage: (image) {
                        setState(() {
                          _selectedImage = image;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Title
                    TextFormField(
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
                            onPressed: _savePlace,
                            icon: const Icon(Icons.add),
                            label: const Text('Add Item'),
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
