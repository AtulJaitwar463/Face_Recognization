import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

//import 'detection_screen.dart';

class MediaDisplayPage extends StatefulWidget {
  final String? imagePath;

  const MediaDisplayPage({Key? key, this.imagePath}) : super(key: key);

  @override
  _MediaDisplayPageState createState() => _MediaDisplayPageState();
}

class _MediaDisplayPageState extends State<MediaDisplayPage> {
  bool loading = false;
  String? enhancedImageUrl;
  late File imageFile;
  TextEditingController imageNameController = TextEditingController();

  Future<void> _processDeblur(BuildContext context) async {
    setState(() {
      loading = true;
    });

    try {
      if (widget.imagePath != null) {
        final bytes = await File(widget.imagePath!).readAsBytes();

        final response = await http.post(
          Uri.parse('https://developer.remini.ai/api/tasks'),
          headers: {
            'Authorization': 'Bearer 23RXpzbH-Lgb3BXoqIqicxWvSVkwD4Y1qACcCWAGFGhkT85D', // Replace with your Remini API key
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'image_content_type': 'image/jpeg',
            'version': '1.2',
            'denoise': true,
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final uploadUrl = data['upload_url'];
          final uploadHeaders = data['upload_headers'];

          final uploadResponse = await http.put(
            Uri.parse(uploadUrl),
            headers: Map<String, String>.from(uploadHeaders),
            body: bytes,
          );

          if (uploadResponse.statusCode == 200) {
            final taskId = data['task_id'];
            await _processTask(taskId, context);
            await _checkTaskStatus(taskId, context);
          } else {
            throw Exception('Failed to upload image: ${uploadResponse.reasonPhrase}');
          }
        } else {
          throw Exception('Failed to submit task: ${response.reasonPhrase}');
        }
      }
    } catch (e) {
      print('Error: $e');
      final snackBar = SnackBar(content: Text('Error: $e'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    setState(() {
      loading = false;
    });
  }

  Future<void> _processTask(String taskId, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('https://developer.remini.ai/api/tasks/$taskId/process'),
        headers: {
          'Authorization': 'Bearer 23RXpzbH-Lgb3BXoqIqicxWvSVkwD4Y1qACcCWAGFGhkT85D', // Replace with your Remini API key
          'Content-Length': '0',
        },
      );

      if (response.statusCode != 202) {
        throw Exception('Failed to process task: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error processing task: $e');
      final snackBar = SnackBar(content: Text('Error: $e'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _checkTaskStatus(String taskId, BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse('https://developer.remini.ai/api/tasks/$taskId'),
        headers: {
          'Authorization': 'Bearer 23RXpzbH-Lgb3BXoqIqicxWvSVkwD4Y1qACcCWAGFGhkT85D', // Replace with your Remini API key
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final status = data['status'];
        if (status == 'completed') {
          final enhancedImageLink = data['result']['output_url'];
          setState(() {
            enhancedImageUrl = enhancedImageLink;
          });
          final snackBar = SnackBar(content: Text('Enhanced Image downloaded and saved'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          // Save enhanced image
          await _saveImage(enhancedImageLink!);
        } else if (status == 'processing') {
          await Future.delayed(Duration(seconds: 5));
          await _checkTaskStatus(taskId, context);
        } else {
          throw Exception('Task failed $status: ${data['error'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('Failed to check task status: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error checking task status: $e');
      final snackBar = SnackBar(content: Text('Error: $e'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _saveImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final appDir = await getApplicationDocumentsDirectory();
        final filePath = '${appDir.path}/enhanced_image.jpg';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          imageFile = file;
        });
      } else {
        throw Exception('Failed to download image: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Display'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.imagePath != null) Image.file(File(widget.imagePath!)),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _processDeblur(context);
                },
                child: loading ? CircularProgressIndicator() : Text('Deblur'),
              ),

              if (enhancedImageUrl != null) ...[
                SizedBox(height: 20),
                Text('Enter Image Name:'),
                SizedBox(height: 10),
                TextField(
                  controller: imageNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter image name...',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Text('Enhanced Image:'),
                Image.network(
                  enhancedImageUrl!,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {

                  },
                  child: Text('Detect'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
