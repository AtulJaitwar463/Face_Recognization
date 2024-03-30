


import 'package:face_recogniization/Firebase_Services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScren extends StatefulWidget {
  const SplashScren({super.key});

  @override
  State<SplashScren> createState() => _SplashScrenState();
}

class _SplashScrenState extends State<SplashScren> {

  SplashServices splashscren = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashscren.isLogin(context);
    // Timer(Duration(seconds: 5),
    //         ()=>Navigator.of(context).pushReplacement(
    //             MaterialPageRoute(builder: (BuildContext context)=> LoginScreen())));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 350,),
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(500),

            ),
            child: Image.asset('assets/hack2.png'),
          ),
        ],
      )

      )
    );
  }
}
