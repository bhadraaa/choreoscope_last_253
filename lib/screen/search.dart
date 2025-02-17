import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MySearch extends StatefulWidget {
  const MySearch({super.key});

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explore',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: const Color.fromARGB(255, 153, 1, 1),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: 400,
            height: 500, // Adjusted height for better layout
            color: const Color.fromARGB(255, 255, 234, 234),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.image,
                    size: 40,
                    color: Color.fromARGB(255, 147, 5, 5),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Search Mudra',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 125, 1, 1),
                    ),
                  ),
                  const SizedBox(height: 30),
                  MaterialButton(
                    onPressed: _pickImageFromGallery,
                    color: const Color.fromARGB(255, 175, 0, 0),
                    child: const Text(
                      'Upload From Gallery',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  MaterialButton(
                    onPressed: _captureImageFromCamera,
                    color: const Color.fromARGB(255, 175, 0, 0),
                    child: const Text(
                      'Capture from Camera',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _selectedImage != null
                      ? Image.file(
                          _selectedImage!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : const Text(
                          'Please select an image',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (returnedImage != null) {
        setState(() {
          _selectedImage = File(returnedImage.path);
        });
      } else {
        // User canceled the picker
        _showSnackBar('No image selected.');
      }
    } catch (e) {
      _showSnackBar('Failed to pick image: $e');
    }
  }

  Future<void> _captureImageFromCamera() async {
    try {
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (returnedImage != null) {
        setState(() {
          _selectedImage = File(returnedImage.path);
        });
      } else {
        // User canceled the picker
        _showSnackBar('No image captured.');
      }
    } catch (e) {
      _showSnackBar('Failed to capture image: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
