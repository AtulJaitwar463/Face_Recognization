import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class FeedbackPage extends StatefulWidget {
//   @override
//   _FeedbackPageState createState() => _FeedbackPageState();
// }
//
// class _FeedbackPageState extends State<FeedbackPage> {
//   double _rating = 0;
//   TextEditingController _feedbackController = TextEditingController();
//
//   final GlobalKey<FormState> _formKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Feedback Page'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Container(
//                   child: Text(
//                     'How would you rate our app?',
//                     style:
//                         TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               Center(
//                 // child: Container(
//                 //   decoration: BoxDecoration(
//                 //     borderRadius: BorderRadius.circular(8.0),
//                 //     boxShadow: [
//                 //       BoxShadow(
//                 //         color: Colors.grey.withOpacity(0.5),
//                 //         spreadRadius: 2.0,
//                 //         blurRadius: 5.0,
//                 //         offset: const Offset(0, 2),
//                 //       ),
//                 //     ],
//                 //     border: Border.all(
//                 //       color: Colors.white,
//                 //       width: 1.0,
//                 //     ),
//
//                   //),
//                   child: RatingBar.builder(
//                     initialRating: _rating,
//                     minRating: 1,
//                     direction: Axis.horizontal,
//                     allowHalfRating: true,
//                     itemCount: 5,
//                     itemSize: 40.0,
//                     itemBuilder: (context, _) => Icon(
//                       Icons.star,
//                       color: Colors.amber,
//                     ),
//                     onRatingUpdate: (rating) {
//                       setState(() {
//                         _rating = rating;
//                       });
//                     },
//                   ),
//                 ),
//               //),
//               SizedBox(height: 20.0),
//               Text(
//                 'Feedback:',
//                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10.0),
//
//               TextField(
//                 controller: _feedbackController,
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                   hintText: 'Enter your feedback here...',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: () {
//                   _submitFeedback(context);
//                 },
//                 child: Text('Submit Feedback'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _submitFeedback(BuildContext context) {
//     String feedback = _feedbackController.text;
//     if (_rating > 0 && feedback.isNotEmpty) {
//       FirebaseFirestore.instance.collection('feedback').add({
//         'rating': _rating,
//         'feedback': feedback,
//       }).then((_) {
//         _showSuccessDialog(context);
//         print('Feedback sent successfully');
//       }).catchError((error) {
//         print('Error sending feedback: $error');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to send feedback. Please try again later.'),
//           ),
//         );
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please provide both rating and feedback.'),
//         ),
//       );
//     }
//   }
//
//   void _showSuccessDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Feedback Sent Successfully'),
//           content: Text('Thank you for your feedback!'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _feedbackController.dispose();
//     super.dispose();
//   }
// }

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  double _rating = 0;
  TextEditingController _feedbackController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2.0,
                  blurRadius: 5.0,
                  offset: const Offset(0, 2),
                ),
              ],
              color: Colors.white,
            ),
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'How would you rate our app?',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10.0),
                Center(
                  child: RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 40.0,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Feedback:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: _feedbackController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Enter your feedback here...',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _submitFeedback(context);
                    },
                    child: Text('Submit Feedback'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitFeedback(BuildContext context) {
    String feedback = _feedbackController.text;
    if (_rating > 0 && feedback.isNotEmpty) {
      FirebaseFirestore.instance.collection('feedback').add({
        'rating': _rating,
        'feedback': feedback,
      }).then((_) {
        print('Feedback sent successfully');
        _showSuccessDialog(context);
        Navigator.pop(context); // Navigate back to the previous screen
      }).catchError((error) {
        print('Error sending feedback: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send feedback. Please try again later.'),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please provide both rating and feedback.'),
        ),
      );
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Feedback Sent Successfully'),
          content: Text('Thank you for your feedback!'),
          icon: Icon(Icons.gpp_good_outlined),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }
}
