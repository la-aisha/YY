import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:yy/model/barchoice.dart';
import 'package:yy/model/user_model.dart';
import 'package:yy/provider/auth_provider.dart';
import 'package:yy/screen/RegisterCostumer.dart';
import 'package:yy/screen/ScreenCustomer/Accueilcustomer.dart';
import 'package:yy/screen/ScreenCustomer/livraison/Destinationcustomer.dart';

import 'package:yy/widgets/card.dart';
import 'package:line_icons/line_icons.dart';

class Homescreencustomer extends StatefulWidget {
  const Homescreencustomer({Key? key}) : super(key: key);

  @override
  State<Homescreencustomer> createState() => _HomescreencustomerState();
}

class _HomescreencustomerState extends State<Homescreencustomer> {
  int currentIndex = 1;
  List<Barchoice> items = [];

  void barTapedd(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    items = [
      Barchoice(
          label: "livraison",
          imagePath: 'images/locbar2.png',
          selectedImagePath: 'images/locbar1.png',
          page: DestinationCustomer(),
          imageWidth: 30.0,
          imageHeight: 30),
      Barchoice(
          label: "accueil",
          imagePath: 'images/homebar2.png',
          selectedImagePath: 'images/homebar1.png',
          page: AccueilCustomer(),
          imageWidth: 30.0,
          imageHeight: 30),
      Barchoice(
          label: "message",
          imagePath: 'images/emailbar2.png',
          selectedImagePath: 'images/emailbar1.png',
          page: Container(),
          imageWidth: 30.0,
          imageHeight: 30),
    ];
  }

  @override
  Widget build(BuildContext context) {
    //final ap = Provider.of<MyAuthProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    double width = size.width;
    var height = size.height;
    Color myColor1 = Color.fromRGBO(40, 0, 81, 1);
    Color myColor = Color.fromRGBO(40, 0, 81, 0.1);
    Color myColor2 = Color.fromRGBO(189, 22, 22, 1);

    final List<String> imgList = [
      'images/slider.png',
      'images/slider.png',
      'images/slider.png',
    ];
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: items.map((i) => i.item).toList(),
          onTap: barTapedd,
          iconSize: 10,
        ),
        body: items[currentIndex].page);
  }
}

Container icon(double width, double height, String path, String text,
    BuildContext context, Color color) {
  return Container(
    height: 130,
    width: width * 1 / 3,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: color,
    ),
    child: ElevatedButton(
      onPressed: () {
        print('hello');
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Color.fromRGBO(40, 0, 81, 0.7)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
              color: Color.fromRGBO(40, 0, 81, 0.3),
              //color: Color.fromRGBO(40, 0, 81, 1),
            ),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              path,
              height: 70,
              width: 70,
            ),
            Container(
                //color: Color.fromRGBO(40, 0, 81, 1) ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromRGBO(40, 0, 81, 1),
                ),
                width: width,
                child: Center(
                  child: Text(
                    text,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        //decoration: TextDecoration.underline,
                        // decorationColor: Color.fromRGBO(40, 0, 81, 1),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    ),
  );
}

class CircleAvatarWithGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 40,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(40, 0, 81, 1),
                Color.fromRGBO(115, 51, 100, 1),
                Color.fromRGBO(115, 51, 100, 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
