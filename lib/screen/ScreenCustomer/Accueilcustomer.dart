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
import 'package:yy/widgets/card.dart';
import 'package:line_icons/line_icons.dart';

class AccueilCustomer extends StatefulWidget {
  const AccueilCustomer({Key? key}) : super(key: key);

  @override
  State<AccueilCustomer> createState() => _AccueilCustomerState();
}

class _AccueilCustomerState extends State<AccueilCustomer> {
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
          page: Container(),
          imageWidth: 30.0,
          imageHeight: 30),
      Barchoice(
          label: "accueil",
          imagePath: 'images/homebar2.png',
          selectedImagePath: 'images/homebar1.png',
          page: Container(),
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
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'images/app.png',
                      height: 30,
                    ),
                    Icon(
                      Icons.person,
                      size: 45,
                      color: myColor1,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 35),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dalal ak jamm,",
                      style: TextStyle(fontSize: 15, color: myColor1),
                    ),
                    /*  Text(
                      '${ap.userModel.firstname} ${ap.userModel.firstname}',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 20, color: Colors.black),
                    ), */
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: 130, // Adjust the top position as needed
            bottom: 0,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      ActivityListTile(
                        title: 'Yobul yobal',
                        subtitle: 'devenir convoyeur',
                        trailingImage:
                            Image.asset('images/femme.png', height: 170),
                        color: Color.fromRGBO(115, 51, 100, 0.3),
                        gradient: Color.fromRGBO(115, 51, 100, 0.7),
                        context: context,
                      ),
                      // Add more ActivityListTile widgets as needed
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "tanal lo beug",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      icon(width, height, 'images/motorbike.png', 'livraison',
                          context, Colors.white),
                      icon(width, height, 'images/box.png', 'Depot', context,
                          Colors.white),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      icon(width, height, 'images/partners.png', 'Partenaires',
                          context, Colors.white),
                      icon(width, height, 'images/money.png', 'Tarif', context,
                          Colors.white),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Text(
                      "You bess !",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: imgList.map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: width * 0.8,
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                item,
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

Container icon(double width, double height, String path, String text,
    BuildContext context, Color color) {
  return Container(
    height: 115,
    width: width * 1 / 3,
    /*  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      border: Border.all(
      //color: color, // specify the border color here
      width: 1, // adjust the border width as needed
    ),
      
    ), */
    child: ElevatedButton(
      onPressed: () {
        print('hello');
      },
      style: ButtonStyle(
        elevation: MaterialStatePropertyAll(0),
        backgroundColor: MaterialStateProperty.all(
          Color.fromRGBO(115, 51, 100, 0.2),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Color.fromRGBO(40, 0, 81, 1), width: 1
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
              height: 45,
              width: 45,
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
