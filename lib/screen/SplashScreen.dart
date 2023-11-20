import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yy/screen/OnBoardScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
   void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 8), () {
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => OnboardScreen())); //permet de rediriger vers une autre page sans retour
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(28, 0, 51, 1),
        child: Column(
          children: [
            SizedBox(height: 200,),
            Center(
              child: Image.asset('images/logoblanc.png' ,width: 250,height: 250,),
            ),
            //Image.asset('images/yobul.png' ),
          ],
        ),
      )
    );
  }
}