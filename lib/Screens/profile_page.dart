// import 'dart:typed_data';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart'; // Import Firebase Realtime Database
// import 'package:image_picker/image_picker.dart';
//
// import 'home_screen.dart';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key, required this.title}) : super(key: key); // Fix the super constructor
//   final String title;
//
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   Uint8List? _image;
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final databaseReference = FirebaseDatabase.instance.reference(); // Firebase Realtime Database reference
//
//   void selectImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       final Uint8List img = await pickedFile.readAsBytes();
//       setState(() {
//         _image = img;
//       });
//     }
//   }
//
//   void saveProfile() {
//     // Get the entered name and email
//     final String name = nameController.text;
//     final String email = emailController.text;
//
//     // Store data in Firebase Realtime Database
//     databaseReference.child("profiles").push().set({
//       'name': name,
//       'email': email,
//       // Add the image URL if you're storing the image in Firebase Storage
//     });
//
//     print('Profile Saved Successfully');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 32),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 24),
//                 Stack(
//                   children: [
//                     _image != null
//                         ? CircleAvatar(
//                       radius: 64,
//                       backgroundImage: MemoryImage(_image!),
//                     )
//                         : const CircleAvatar(
//                       radius: 64,
//                       backgroundImage: NetworkImage(
//                           'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg'),
//                     ),
//                     Positioned(
//                       child: IconButton(
//                         onPressed: selectImage,
//                         icon: Icon(Icons.add_a_photo),
//                       ),
//                       bottom: -5,
//                       left: 100,
//                     )
//                   ],
//                 ),
//                 TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(
//                     hintText: "Enter Name",
//                     contentPadding: EdgeInsets.all(10),
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 TextField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     hintText: "Enter Email",
//                     contentPadding: EdgeInsets.all(10),
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: () {
//                     saveProfile();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Profile Saved Successfully'),
//                       ),
//                     );
//                     Navigator.of(context).pushReplacement(
//                       MaterialPageRoute(
//                         builder: (context) => HomeScreen(), // Replace HomeScreen() with your actual home screen widget
//                       ),
//                     );
//                   },
//                   child: Text('Save Profile'),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? _image;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  void fetchProfileData() async {
    try {
      DataSnapshot snapshot = await databaseReference
          .child("profiles")
          .child("user_id")
          .once()
          .then((event) {
        return event.snapshot;
      });
      if (snapshot.value != null) {
        var data = snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          nameController.text = data['name'] ?? ''; // Null check for 'name'
          emailController.text = data['email'] ?? ''; // Null check for 'email'
          if (data['image'] != null) {
            // Decode base64 encoded image string to Uint8List
            _image = base64Decode(data['image']);
          }
        });
      }
    } catch (error) {
      print('Failed to fetch profile data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(20.0),
          width: 350,
          height: 550,
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
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2.0,
                blurRadius: 5.0,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              GestureDetector(
                onTap: selectImage,
                child: CircleAvatar(
                  radius: 64,
                  backgroundImage: _image != null ? MemoryImage(_image!) : null,
                  child: _image == null ? Icon(Icons.add_a_photo) : null,
                ),
              ),
              SizedBox(height: 35),
              Container(
                color: Colors.white,
                child:
              TextField(

                controller: nameController,
                decoration: InputDecoration(

                  hintText: "Enter Name",
                  contentPadding: EdgeInsets.all(10),
                     border: OutlineInputBorder(),
                ),
              ),
              ),
              SizedBox(height: 25),
              Container(
                color: Colors.white,
                child:
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),

                ),
              ),
              ),
              SizedBox(height: 45),
              ElevatedButton(
                onPressed: saveProfile,
                child: Text('Save Profile'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final img = await pickedFile.readAsBytes();
      setState(() {
        _image = img;
      });
    }
  }

  void saveProfile() {
    final String name = nameController.text;
    final String email = emailController.text;

    databaseReference.child("profiles").child("user_id").set({
      'name': name,
      'email': email,
    }).then((_) {
      print('Profile Saved Successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile Saved Successfully'),
        ),
      );
    }).catchError((error) {
      print('Failed to save profile: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save profile'),
        ),
      );
    });
  }
}
