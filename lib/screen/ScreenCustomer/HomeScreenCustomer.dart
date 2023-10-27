import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yy/provider/auth_provider.dart';
import 'package:yy/screen/RegisterCostumer.dart';

class Homescreencustomer extends StatefulWidget {
  const Homescreencustomer({Key? key}) : super(key: key);

  @override
  State<Homescreencustomer> createState() => _HomescreencustomerState();
}

class _HomescreencustomerState extends State<Homescreencustomer> {
  @override
  Widget build(BuildContext context) {
    // final ap = Provider.of<AuthProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    double width = size.width;
    var height = size.height;
    Color myColor1 = Color.fromRGBO(40, 0, 81, 1);
    Color myColor2 = Color.fromRGBO(189, 22, 22, 1);

    final List<String> imgList = [
      'images/1.png',
      'images/2.png',
      'images/3.png',
    ];

    int currentIndex = 0;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Color.fromRGBO(40, 0, 81, 1),
                  Color.fromRGBO(115, 51, 100, 1),
                  Color.fromRGBO(115, 51, 100, 1),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                Padding(padding: EdgeInsets.all(15) ,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [                
                    Image.asset(
                      'images/app.png',
                      height: 45,
                      //color: Colors.grey[800],
                    ),
                    Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.white,
                    )
                  ],)
                ),
                const SizedBox(height: 10),

                  // welcome home
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                   // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Dalal ak jamm,",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        'Aissatou seye',
                        style: GoogleFonts.bebasNeue(fontSize: 30 ,color: Colors.white),
                      ),
                    ],
                  ),
                ),

                
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
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'hello boy',
                          //'${ap.userModel.firstname} ${ap.userModel.lastname}',
                          style: GoogleFonts.breeSerif(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 160, // Adjust the top position as needed
            bottom: 0,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Container(
                height: height,
                width: width ,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Colors.white),
                child: Column(
                  children: [
                   /*  SizedBox(
                      height: 10,
                    ),

                    Container(
                      height: 230,
                      child: Stack(
                        children: [
                          
                        ],
                      ),

                    ), */

                     SizedBox(
                      height: 10,
                    ),


                    // Add your scrollable content here
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
                                //color: Colors.pink,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  width: width * 0.8,
                                  item,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    Center(
                      child : Text(
                        "tanal lo beug",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            //decoration: TextDecoration.underline,
                            // decorationColor: Color.fromRGBO(40, 0, 81, 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,) ,
                   
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        icon(width, height, 'images/home1.png', 'livraison', context) ,
                        icon(width, height, 'images/home4.png', 'Depot', context) ,
                      ],
                    ),
                    SizedBox(height: 20,) ,
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        icon(width, height, 'images/home5.png', 'Partenaires', context) ,
                        icon(width, height, 'images/home3.png', 'Tarif', context) ,
                      ],
                    ),
                     Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                           // style: Theme.of(context).textTheme.display1,
                            children: [
                              TextSpan(text: "Best of the "),
                              TextSpan(
                                text: "day",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ]
                    ),)
                     ,                       bestOfTheDayCard(size*0.8, context),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 Container bestOfTheDayCard(Size size, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 245,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 24,
                top: 24,
                right: size.width * .35,
              ),
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFEAEAEA).withOpacity(.45),
                borderRadius: BorderRadius.circular(29),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(
                      "New York Time Best For 11th March 2020",
                      style: TextStyle(
                        fontSize: 9,
                        //color: kLightBlackColor,
                      ),
                    ),
                  ),
                  Text(
                    "How To Win \nFriends &  Influence",
                    //style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    "Gary Venchuk",
                    style: TextStyle(color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        /* Padding(
                          padding: EdgeInsets.only(right: 10.0), 
                          child: BookRating(score: 4.9),
                        ),
                        Expanded(
                          child: Text(
                            "When the earth was flat and everyone wanted to win the game of the best and people….",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              color: kLightBlackColor,
                            ),
                          ),
                        ), */
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              "images/femme.png",
              width: size.width * .37,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              height: 40,
              width: size.width * .3,
              /* child: TwoSideRoundedButton(
                text: "Read",
                radious: 24,
                press: () {},
              ), */
            ),
          ),
        ],
      ),
    );
  }
 /*  Container bestOfTheDayCard(Size size, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 245,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 24,
                top: 24,
                right: size.width * .35,
              ),
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFEAEAEA).withOpacity(.45),
                borderRadius: BorderRadius.circular(29),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(
                      "New York Time Best For 11th March 2020",
                      style: TextStyle(
                        fontSize: 9,
                        //color: kLightBlackColor,
                      ),
                    ),
                  ),
                  Text(
                    "How To Win \nFriends &  Influence",
                    //style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    "Gary Venchuk",
                    //style: TextStyle(color: kLightBlackColor),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 10.0), 
                          child:  textfield(placeHolder: "")//BookRating(score: 4.9),
                        ),
                        Expanded(
                          child: Text(
                            "When the earth was flat and everyone wanted to win the game of the best and people….",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              //color: kLightBlackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              "images/femme.png",
              width: size.width * .37,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              height: 40,
              width: size.width * .3,
              child: Text('hello') /* TwoSideRoundedButton(
                text: "Read",
                radious: 24,
                press: () {}, */
              
            ),
          ),
        ],
      ),
    );
  }

 */
Container icon(double width, double height , String path ,String text ,BuildContext context) {
  return Container(
    height: 130,
    width: width * 1 / 3,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      //color: Colors.white,
    ),
    child: ElevatedButton(
      onPressed: () {
        print('hello');
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
      child: Padding(
        padding: EdgeInsets.only(top: 5 ,bottom: 5),
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
                borderRadius: BorderRadius.circular(5) ,
                color: Color.fromRGBO(40, 0, 81, 1) ,

              ),
              width: width,
              child:  Center(
                child:  Text(
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

              )
              
             

            )
           
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
