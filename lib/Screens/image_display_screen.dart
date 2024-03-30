
import 'dart:convert';
import 'dart:io';

import 'package:face_recogniization/Screens/deblure_result_page.dart';
import 'package:face_recogniization/Widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MediaDisplayPage extends StatefulWidget {
  final String? imagePath;
  final String? videoPath;

  const MediaDisplayPage({Key? key, this.imagePath, this.videoPath})
      : super(key: key);

  @override
  _MediaDisplayPageState createState() => _MediaDisplayPageState();
}

class _MediaDisplayPageState extends State<MediaDisplayPage> {
  bool loading = false;

  // Future<void> _processDeblur(BuildContext context) async {
  //   if (widget.imagePath != null) {
  //     // Send image to backend for deblurring
  //     final bytes = File(widget.imagePath!).readAsBytesSync();
  //     final response = await http.post(
  //       Uri.parse('http://your-backend-url/deblur'), // Replace with your backend URL
  //       body: bytes, // Send image as bytes
  //     );
  //
  //     if (response.statusCode == 200) {
  //       // Image deblurred successfully
  //       // Parse response to get deblurred image data
  //       final Map<String, dynamic> data = jsonDecode(response.body);
  //       final String? deblurredImagePath = data['deblurred_image'];
  //
  //       if (deblurredImagePath != null) {
  //         // Navigate to DeblurResultPage with deblurred image path
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => DeblureResultPage(
  //               deblurredImagePath: deblurredImagePath,
  //             ),
  //           ),
  //         );
  //       } else {
  //         // Handle error: No deblurred image path in response
  //       }
  //     } else {
  //       // Handle error: HTTP request failed
  //     }
  //   }
  // }

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
            if (widget.imagePath != null) Image.file(File(widget.imagePath!)),

            SizedBox(height: 20),
            RoundButton(
              title: "DeBlure",
              loading: loading,
              onTap: () {
                //_processDeblur(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
