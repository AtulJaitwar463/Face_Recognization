import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HelpAndSupportPage extends StatefulWidget {
  @override
  _HelpAndSupportPageState createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();

  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  String _responseMessage = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Send data to Firebase
      _databaseReference.child("support_requests").push().set({
        'message': _messageController.text,
      }).then((_) {
        setState(() {
          _responseMessage = 'Your request has been submitted successfully!';
        });
      }).catchError((error) {
        setState(() {
          _responseMessage =
          'An error occurred while submitting your request. Please try again later.';
        });
      });

      // Clear form field after submission
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help and Support'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(labelText: 'Message'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your message';
                      }
                      return null;
                    },
                    maxLines: 5,
                  ),
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              _responseMessage,
              style: TextStyle(
                color: _responseMessage.contains('error') ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


