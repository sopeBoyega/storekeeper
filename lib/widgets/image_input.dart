import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({
    super.key,
    required this.onSelectImage,
    this.initialImage,
  });

  final void Function(File image) onSelectImage;
  final File? initialImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImage;
  }

  Future<void> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      source: source,
      maxWidth: 600,
    );
    if (pickedImage == null) return;

    final file = File(pickedImage.path);

    setState(() {
      _selectedImage = file;
    });

    widget.onSelectImage(file);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget content;

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: () => _pickImage(ImageSource.camera),
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    } else {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.image_outlined,
            size: 48,
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
          const SizedBox(height: 8),
          Text('No image', style: theme.textTheme.bodyMedium),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: const Icon(Icons.camera_alt),
                label: const Text('Camera'),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.photo_library),
                label: const Text('Gallery'),
              ),
            ],
          )
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: theme.colorScheme.primary.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      child: content,
    );
  }
}
