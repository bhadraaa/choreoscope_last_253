import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image/image.dart' as img;
import 'dart:typed_data';
import 'package:lottie/lottie.dart';

class MySearch extends StatefulWidget {
  const MySearch({super.key});

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  File? _selectedImage;
  String? _predictedMudra;
  //double? _confidence;
  String? _mudraDetails;
  bool _showDetails = false;
  bool _show = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore Mudras',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(255, 153, 1, 1),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: 400,
            height: 1000,
            color: const Color.fromARGB(255, 255, 234, 234),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  //width: 20,

                  child: Lottie.asset(
                    'assets/animations/Animation - 2.json',
                    repeat: false,
                    width: 50,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                const Text(
                  'Search Mudra',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 125, 1, 1)),
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  onPressed: _pickImageFromGallery,
                  color: const Color.fromARGB(255, 175, 0, 0),
                  child: const Text(
                    'Upload From Gallery',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  onPressed: _captureImageFromCamera,
                  color: const Color.fromARGB(255, 175, 0, 0),
                  child: const Text(
                    'Capture from Camera',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
                if (_selectedImage != null)
                  Column(
                    children: [
                      Image.file(_selectedImage!,
                          width: 200, height: 150, fit: BoxFit.cover),
                      const SizedBox(height: 10),
                      if (_predictedMudra != null || _show == true)
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mudra: $_predictedMudra",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 148, 0, 0)),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showDetails = !_showDetails;
                                    });
                                  },
                                  child: Text(_showDetails
                                      ? "Hide Details"
                                      : "Show Details"),
                                ),
                                if (_showDetails && _mudraDetails != null)
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Card(
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Details about $_predictedMudra",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.redAccent),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              _mudraDetails ??
                                                  'No details available.',
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  )
                else
                  const Text(
                    'Please select an image',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _updateSelectedImage(pickedFile);
  }

  Future<void> _captureImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _updateSelectedImage(pickedFile);
  }

  void _updateSelectedImage(XFile? pickedFile) {
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) {
      _showSnackBar("No image selected.");
      return;
    }

    try {
      if (mounted) {
        setState(() => _show = true); // Show loading indicator
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("http://192.168.132.248:5000/predict"),
      );
      request.files.add(
          await http.MultipartFile.fromPath('image', _selectedImage!.path));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var decodedResponse = json.decode(responseBody);

      if (response.statusCode == 200 && decodedResponse.containsKey('mudra')) {
        if (mounted) {
          setState(() {
            _predictedMudra = decodedResponse['mudra'];
            _mudraDetails =
                decodedResponse['details'] ?? "No details available.";
          });
        }
      } else {
        _showSnackBar(
            "Error: ${decodedResponse['error'] ?? 'Unexpected error occurred'}");
        if (mounted) {
          setState(() {
            _predictedMudra = null;
            _mudraDetails = null;
          });
        }
      }
    } catch (e) {
      _showSnackBar("Failed to connect to API: $e");
      if (mounted) {
        setState(() {
          _predictedMudra = null;
          _mudraDetails = null;
        });
      }
    } finally {
      if (mounted) {
        setState(() => _show = false); // Hide loading indicator
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
