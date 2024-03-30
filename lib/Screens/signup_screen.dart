import 'package:face_recogniization/Screens/home_screen.dart';
import 'package:face_recogniization/Screens/login_screen.dart';
import 'package:face_recogniization/Utils/utils.dart';
import 'package:face_recogniization/Widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool loading =false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void login(){
    setState(() {
      loading=true;
    });
    if (passwordController.text != confirmPasswordController.text) {
      Utils().toastMessage("Passwords do not match");
      setState(() {
        loading = false;
      });
      return;
    }
    _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString() ,
        password: passwordController.text.toString()).then((value){
      // Navigate to home page upon successful sign-up
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> HomeScreen()));
      setState(() {
        loading=false;
      });
    }).onError((error, stackTrace){
      Utils().toastMessage(error.toString());
      setState(() {
        loading=false;
      });
    });
  }

  void _showSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sign up successful!'),
        backgroundColor: Colors.green,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child:Scaffold(
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
                    ]
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 70,),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(500),

                  ),
                  child: Image.asset('assets/hack2.png'),
                ),

                SizedBox(height: 15,),
                Text("YOur logo",style: TextStyle(color: Colors.white,fontSize: 20),),

                SizedBox(height: 15,),
                Container(
                    height: 480,
                    width: 325,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Form(
                      key: _formKey,


                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 30,),
                          Text('SignUp',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),

                          Text('Please Sign Up account',style: TextStyle(fontSize: 15,color:Colors.grey),),
                          SizedBox(height: 20,),

                          Container(
                            width:250,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.mail,
                                    size: 20,)
                              ),
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
                            width:250,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: 'password',
                                  prefixIcon: Icon(Icons.lock,
                                    size: 20,)
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter password";
                                }
                                return null;
                              },

                            ),
                            //child:Te
                          ),
                          Container(
                            width:250,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: 'Comfirm password',
                                  prefixIcon: Icon(Icons.lock,
                                    size: 20,)
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },

                            ),
                            //child:Te
                          ),

                          SizedBox(height: 10,),
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
                                      ]

                                  )
                              ),

                              child:
                              RoundButton(
                                  title: "SignUp",
                                  loading: loading,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {

                                      login();
                                      // Implement your sign-up logic here
                                      // Upon successful sign-up, show success message
                                      _showSuccessSnackbar(context);
                                    };
                                  }),

                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Already have an account ?',style: TextStyle(fontSize: 15,color:Colors.black),),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  },
                                  child: Text('Login')),

                            ],
                          ),
                        ],
                      ),
                    )
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