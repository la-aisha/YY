import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:yy/screen/Register.dart';
//import 'package:yy/screen/Welcome.dart';




class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {

  

 final List<PageViewModel>? pages=[
  PageViewModel(
      title:'Lorem ipsum dolor' ,
      body:'Curabitur rhoncus tincidunt augue, at sollicitudin mi rhoncus vitae. In hac habitasse platea dictumst. Quisque pellentesque, mauris ut eleifend tincidunt, ' ,
      image: Center(child: Image.asset('images/location.png'),),
      decoration: PageDecoration(
      titleTextStyle: GoogleFonts.breeSerif(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        fontSize: 30,
        fontStyle: FontStyle.normal,
      ),
      bodyTextStyle :  GoogleFonts.breeSerif(
        fontWeight: FontWeight.w300,
        color: Colors.black87,
        fontSize: 15,
        fontStyle: FontStyle.normal,
      ),
      )

    ),
    PageViewModel(
      title:'sed do incididunt ' ,
      body:'Curabitur rhoncus tincidunt augue, at sollicitudin mi rhoncus vitae. In hac habitasse platea dictumst. Quisque pellentesque, mauris ut eleifend tincidunt, ' ,
      
      image: Center(child: Image.asset('images/bagage.png'),),
      decoration: PageDecoration(
      titleTextStyle: GoogleFonts.breeSerif(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 30,
            fontStyle: FontStyle.normal,
          ),
          bodyTextStyle :  GoogleFonts.breeSerif(
            fontWeight: FontWeight.w300,
            color: Colors.black87,
            fontSize: 15,
            fontStyle: FontStyle.normal,
          ),
      )

    ),
     PageViewModel(
      title:' quis nostrud exercit' ,
      body:'Curabitur rhoncus tincidunt augue, at sollicitudin mi rhoncus vitae. In hac habitasse platea dictumst. Quisque pellentesque, mauris ut eleifend tincidunt, ' ,
      /*  footer:ElevatedButton(onPressed: (){},
      child: const Text('lets go')),  */
      image: Center(child: Image.asset('images/femme.png'),),
      decoration: PageDecoration(
     titleTextStyle: GoogleFonts.breeSerif(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 30,
            fontStyle: FontStyle.normal,
          ),
          bodyTextStyle :  GoogleFonts.breeSerif(
            fontWeight: FontWeight.w300,
            color: Colors.black87,
            fontSize: 15,
            fontStyle: FontStyle.normal,
          ),)

    ),
    
   
  ];


  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 80, 12, 12),
         child: IntroductionScreen(
        
        pages: pages,
        nextFlex: 20,
        dotsFlex: 20,
       
        dotsDecorator: const DotsDecorator(
        size: Size(7, 7.0),
        color: Color.fromRGBO(40, 0,81, 50),
        activeColor: Color.fromRGBO(40, 0,81, 1),

        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
        showBackButton: false,
        done:Image.asset('images/arrow3.png',width: 35,height: 30,),
        showNextButton: true,
        next:Image.asset('images/arrow3.png',width: 35,height: 25,),
        onDone: ()=>onDone(context) ,
        curve: Curves.bounceOut,

      )),
      

    );  }

  void onDone(context) async{
    /* final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false); */

   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Welcome(),));

  }
}