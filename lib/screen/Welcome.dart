import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yy/model/user_model.dart';
import 'package:yy/provider/auth_provider.dart';
import 'package:yy/screen/RegisterCostumer.dart';
import 'package:yy/screen/RegisterDriver.dart';
import 'package:yy/screen/ScreenCustomer/HomeScreenCustomer.dart';
import 'package:yy/screen/ScreenDriver.dart/HomeScreenDriver.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    //Color myColor = Color(0xFF1E3148);
    Color myColor1 = Color.fromRGBO(40, 0, 81, 1);
    Color myColor2 = Color.fromRGBO(189, 22, 22, 1);
    final ap = Provider.of<AuthProvider>(context, listen: false);

    Container client(double width, double height) {
      return Container(
        width: width * 3 / 4,
        height: height,
        child: ElevatedButton(
          child: Text(
            'Je cherche un convoyeur',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          onPressed: () async {
            if (ap.isSignedIn == true) {
              await ap.getDataFromSP().whenComplete(() => Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (context) => Homescreencustomer())));

              /*  Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Homescreencustomer())); */
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RegisterCostumer(
                        user: new UserModel(
                            firstname: "",
                            lastname: "",
                            createdAt: "",
                            phoneNumber: "",
                            uid: ""),
                      )));
            }
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              backgroundColor:
                  MaterialStateProperty.all(Color.fromRGBO(189, 22, 22, 1))),
        ),
      );
    }

    Container convoyeur(double width, double height) {
      return Container(
          width: width * 3 / 4,
          height: height,
          child: ElevatedButton(
            child: Text(
              'Je suis un convoyeur',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color:
                    Color.fromRGBO(40, 0, 81, 1), // Set your desired color here
              ),
            ),
            onPressed: () {
              ap.isSignedIn == true // then display shared pref data
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Homescreendriver()))
                  : Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Welcome()));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(
                    color: Color.fromRGBO(40, 0, 81, 1),
                    //color: Color.fromRGBO(40, 0, 81, 1),
                  ),
                ),
              ),
            ),
          ));
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Spacer(),
            Image.asset('images/yobal.png', width: 50, height: 50),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    //color: Colors.blue,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'BIENVENUE,Q',
                            style: GoogleFonts.breeSerif(
                              textStyle: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(40, 0, 81, 1),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: Color.fromRGBO(40, 0, 81, 1),
                              ),
                            ),
                          ),
                          TextSpan(
                              text: 'ue cherchez-vous?',
                              style: GoogleFonts.breeSerif(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    //color: Colors.red,
                    child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        )),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 200,),
            Spacer(),
            client(width * 3 / 4, 50),
            SizedBox(
              height: 15,
            ),
            convoyeur(width * 3 / 4, 50),
            Spacer()
          ],
        ),
      ),
    );
  }
}
