import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class FaceDetectionScreen extends StatefulWidget {
  final String? imagePath;

  const FaceDetectionScreen({Key? key, this.imagePath}) : super(key: key);

  @override
  _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  bool loading = false;
  late File _imageFile;

  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadImage() async {
    if (_imageFile == null) {
      print('No image selected.');
      return;
    }

    setState(() {
      loading = true;
    });

    // Change this URL to your FastAPI endpoint
    var url = 'http://your-fastapi-endpoint.com/upload';

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Add your image file to the request
    request.files.add(await http.MultipartFile.fromPath('image', _imageFile.path));

    // Send the request
    var response = await request.send();

    // Check the response
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image. Error ${response.statusCode}');
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Face Detection',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF8A2387),
                Color(0xFFE94057),
                Color(0xFFF27121),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null) Image.file(_imageFile),
            SizedBox(height: 20),
            RoundButton(
              title: "Pick Image",
              onTap: getImage, // Use VoidCallback instead of Future<void> Function(File)
            ),
            SizedBox(height: 20),
            RoundButton(
              title: "Upload Image",
              loading: loading,
              onTap: uploadImage,
            ),
          ],
        ),
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onTap;

  const RoundButton({Key? key, required this.title, this.loading = false, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: loading
          ? CircularProgressIndicator()
          : Text(
        title,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}

