import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../Widgets/round_button.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late Future<File?> _imageFuture;
  final ImagePicker _imagePicker = ImagePicker();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _initializeImageFuture();
  }

  void _initializeImageFuture() {
    _imageFuture = _getImage();
  }

  Future<File?> _getImage() async {
    final image = await _imagePicker.getImage(source: ImageSource.camera);
    return image != null ? File(image.path) : null;
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
        body: Column(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
          ),
          Center(
            child: FutureBuilder<File?>(
              future: _imageFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data != null) {
                  return
                Container(
                    width: 320,
                    height: 320,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: FileImage(snapshot.data!),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2.0,
                          blurRadius: 5.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Text("No image selected");
                }
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          RoundButton(title: "DeBlure", loading: loading, onTap: () {}),
        ]));
  }
}
