import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:face_recogniization/Screens/deblure_result_page.dart';

import '../Widgets/round_button.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

class MediaDisplayPage extends StatefulWidget {
  final String? imagePath;

  const MediaDisplayPage({Key? key, this.imagePath}) : super(key: key);

  @override
  _MediaDisplayPageState createState() => _MediaDisplayPageState();
}

class _MediaDisplayPageState extends State<MediaDisplayPage> {
  bool loading = false;
  // final String apiKey = 'wEkwOnGVOPGB3iG6ha3R8uLlzJ5zfX29eSlqh8tAkFjLcKLY';
  // String? outputImageUrl;
  //
  // Future<void> _processDeblur(BuildContext context) async {
  //   if (widget.imagePath != null) {
  //     setState(() {
  //       loading = true;
  //     });
  //
  //     try {
  //       File imageFile = File(widget.imagePath!);
  //       final bytes = await imageFile.readAsBytes();
  //       final md5Hash = md5.convert(bytes);
  //       final imageMd5 = md5Hash.toString();
  //       final encodedImageMd5 = base64Encode(utf8.encode(imageMd5));
  //
  //       final submitTaskResponse = await http.post(
  //         Uri.parse('https://developer.remini.ai/api/tasks'),
  //         headers: {
  //           'Authorization': 'Bearer $apiKey',
  //           'Content-Type': 'application/json',
  //         },
  //         body: jsonEncode({
  //           'tools': [
  //             {'type': 'face_enhance', 'mode': 'beautify'},
  //             {'type': 'background_enhance', 'mode': 'base'},
  //           ],
  //           'image_md5': encodedImageMd5,
  //           'image_content_type': 'image/jpeg',
  //           'output_content_type': 'image/jpeg',
  //         }),
  //       );
  //
  //       if (submitTaskResponse.statusCode == 200) {
  //         final submitTaskData = jsonDecode(submitTaskResponse.body);
  //         final String taskId = submitTaskData['task_id'];
  //
  //         final processTaskResponse = await http.post(
  //           Uri.parse('https://developer.remini.ai/api/tasks/$taskId/process'),
  //           headers: {'Authorization': 'Bearer $apiKey'},
  //         );
  //
  //         if (processTaskResponse.statusCode == 202) {
  //           // Polling for task completion
  //           while (outputImageUrl == null) {
  //             await Future.delayed(Duration(seconds: 5));
  //             outputImageUrl = await _checkTaskStatus(taskId);
  //           }
  //
  //           if (outputImageUrl != null) {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => DeblureResultPage(deblurredImagePath: outputImageUrl!),
  //               ),
  //             );
  //           } else {
  //             print('Error: Unable to fetch output image URL');
  //           }
  //         }
  //       }
  //     } catch (e) {
  //       print('Error: $e');
  //     } finally {
  //       setState(() {
  //         loading = false;
  //       });
  //     }
  //   }
  // }
  // Future<String?> _checkTaskStatus(String taskId) async {
  //   try {
  //     final taskStatusResponse = await http.get(
  //       Uri.parse('https://developer.remini.ai/api/tasks/$taskId'),
  //       headers: {'Authorization': 'Bearer $apiKey'},
  //     );
  //
  //     if (taskStatusResponse.statusCode == 200) {
  //       final taskStatusData = jsonDecode(taskStatusResponse.body);
  //       final String taskStatus = taskStatusData['status'];
  //
  //       if (taskStatus == 'completed') {
  //         return taskStatusData['result']['output_url'];
  //       }
  //     }
  //   } catch (e) {
  //     print('Error checking task status: $e');
  //   }
  //
  //   return null; // Return null if task is not completed
  // }

  Future<void> uploadImage(File imageFile) async {
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse('http://your-fastapi-server/upload/');
    var request = http.MultipartRequest('POST', uri);
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Error uploading image: ${response.reasonPhrase}');
      //
    }
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
            if (widget.imagePath != null) Image.file(File(widget.imagePath!)),
            SizedBox(height: 20),
            RoundButton(
                title: "DeBlure",
                loading: loading,
                onTap: () {
                  uploadImage;
                }),
          ],
        ),
      ),
    );
  }
}
