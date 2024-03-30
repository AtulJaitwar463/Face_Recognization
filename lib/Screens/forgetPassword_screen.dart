import 'package:face_recogniization/Utils/utils.dart';
import 'package:face_recogniization/Widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  final emailController =TextEditingController();
  final auth =FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Email',
            ),
          ),
          SizedBox(height: 40,),
          RoundButton(title: 'Forget', onTap: (){
            auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
              Utils().toastMessage("We have sent your email to recover password,please check Email");
            }).onError((error, stackTrace) {
              Utils().toastMessage(error.toString());
            });
          })
        ],
      ),

      ),
    );
  }
}
