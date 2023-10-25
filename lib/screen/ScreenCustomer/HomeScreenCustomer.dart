import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yy/provider/auth_provider.dart';

class Homescreencustomer extends StatefulWidget {
  const Homescreencustomer({super.key});

  @override
  State<Homescreencustomer> createState() => _HomescreencustomerState();
}

class _HomescreencustomerState extends State<Homescreencustomer> {
  final List<IconData> icons = [
    Icons.person,
    Icons.home,
    Icons.favorite,
    Icons.camera,
    Icons.music_note,
    Icons.star,
    Icons.shopping_cart,
    Icons.access_alarm,
    Icons.accessibility,
    Icons.ac_unit,
  ];
  @override
  Widget build(BuildContext context) {
    //final user = FirebaseAuth.instance.currentUser;
    final ap = Provider.of<AuthProvider>(context, listen: false);
    /* return Container(
      color: Colors.blue,
      child : Column(
        children: [
          Text(ap.userModel.firstname),
         Text(ap.userModel.lastname),
          Text(ap.userModel.phoneNumber),



        ],
      )
    ); */
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color.fromRGBO(40, 0, 81, 1),
              //Color.fromRGBO(115, 51, 100, 1),
              Color.fromRGBO(115, 51, 100, 1),
              Color.fromRGBO(115, 51, 100, 1),
            ]),
          ),
          child: Column(
            children: [
              /*  Container(
              child: Padding (
                padding: EdgeInsets.only(top: 80),
                child: Text("Hello ${ap.userModel.firstname} ${ap.userModel.lastname}" , style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                )), ),
            ), */
              Container(
                child: Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hello,',
                          style: GoogleFonts.breeSerif(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 18,
                            // decoration: TextDecoration.underline,
                            //decorationColor: Color(0xFFBD1616),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${ap.userModel.firstname} ${ap.userModel.lastname}',
                          style: GoogleFonts.breeSerif(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 150.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white,
            ),
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.blue,
                      height: 200,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          //itemCount: 4,
                          itemBuilder: (context, index) {
                            return buildIcon(icons[index]);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget buildIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.green],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
