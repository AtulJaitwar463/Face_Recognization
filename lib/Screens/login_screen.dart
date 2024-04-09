import 'package:face_recogniization/Screens/forgetPassword_screen.dart';
import 'package:face_recogniization/Screens/home_screen.dart';
import 'package:face_recogniization/Screens/signup_screen.dart';
import 'package:face_recogniization/Utils/utils.dart';
import 'package:face_recogniization/Widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool loading = false;
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text, password: passController.text)
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color(0xFF8A2387),
                  Color(0xFFE94057),
                  Color(0xFFF27121),
                ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(500),
                  ),
                  child: Image.asset('assets/hack2.png'),
                ),

                SizedBox(
                  height: 15,
                ),
                Text(
                  " ",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),

                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 480,
                    width: 325,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Please Login to your account',
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 250,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(
                                    Icons.mail,
                                    size: 20,
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Email";
                                }
                                return null;
                              },
                            ),
                            //child:Te
                          ),
                          Container(
                            width: 250,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: passController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: 'password',
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    size: 20,
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter password";
                                }
                                return null;
                              },
                            ),
                            //child:Te
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgetPasswordScreen()));
                                  },
                                  child: Text('Forget Password',
                                      style:
                                          TextStyle(color: Colors.blue[700])),
                                )
                              ],
                            ),
                          ),

                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              width: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xFF8A2387),
                                        Color(0xFFE94057),
                                        Color(0xFFF27121),
                                      ])),
                              child: RoundButton(
                                  title: "Login",
                                  loading: loading,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      login();
                                    }
                                    ;
                                  }),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Don't have an Account ?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpPage()));
                                  },
                                  child: Text('Sign Up'))
                            ],
                          ),
                        ],
                      ),
                    ),
                )
                //BorderRadius.circular(2]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
