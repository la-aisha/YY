import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yy/provider/auth_provider.dart';

class Homescreencustomer extends StatefulWidget {
  const Homescreencustomer({Key? key}) : super(key: key);

  @override
  State<Homescreencustomer> createState() => _HomescreencustomerState();
}

class _HomescreencustomerState extends State<Homescreencustomer> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
     Color myColor1 = Color.fromRGBO(40, 0, 81, 1);
    Color myColor2 = Color.fromRGBO(189, 22, 22, 1);

    List imageList = [
      {"id": 1, "image_path": 'images/1.png'},
      {"id": 2, "image_path": 'images/2.png'},
      {"id": 3, "image_path": 'images/3.png'}
    ];
    final CarouselController carouselController = CarouselController();
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
              children: [
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
                          '${ap.userModel.firstname} ${ap.userModel.lastname}',
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
              child: Column(
                children: [
                  /* Container(
                    height: 200, // Set a fixed height for the ListView
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatarWithGradient(),
                            CircleAvatarWithGradient(),
                            CircleAvatarWithGradient(),
                            CircleAvatarWithGradient(),
                          ],
                        ),
                      ],
                    ),
                  ), */
                  SizedBox(height: 10),
                  // Other widgets in the Column
                  Stack(
                  children: [
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Container(
                        width:width*0.8,
                        height: height*0.8,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        //color: Colors.amber,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print(currentIndex);
                      },
                      child: CarouselSlider(
                        items: imageList
                            .map(
                              (item) => Image.asset(
                                item['image_path'],
                                fit: BoxFit.cover,
                                width: width*0.8,
                                
                              ),
                            )
                            .toList(),
                        carouselController: carouselController,
                        options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          aspectRatio: 2,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imageList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => carouselController.animateToPage(entry.key),
                            child: Container(
                              width: currentIndex == entry.key ? 17 : 7,
                              height: 7.0,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 3.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: currentIndex == entry.key
                                    ? myColor1
                                    : myColor1,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                ],
              ),
            ),
          ),
              
          
        ],
      ),
  );
  }
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
