import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:yy/provider/auth_provider.dart';
import 'package:yy/screen/RegisterCostumer.dart';
import 'package:yy/widgets/card.dart';
import 'package:line_icons/line_icons.dart';

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
        Color myColor = Color.fromRGBO(40, 0, 81, 0.1);

    Color myColor2 = Color.fromRGBO(189, 22, 22, 1);

    final List<String> imgList = [
      'images/slider.png',
      'images/slider.png',
      'images/slider.png',
    ];
int _selectedIndex = 0;
       const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

    const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

    int currentIndex = 0;
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.map,
                  text: 'livraison',
                ),
                GButton(
                  icon: LineIcons.home,
                  text: 'accueil',
                ),
               
                GButton(
                  icon: LineIcons.envelope,
                  text: 'notification',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),),),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
              padding: const EdgeInsets.only(top: 40 ,left: 40 ,right: 40),
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
                ],),
              ),
              Padding(
                padding: EdgeInsets.only(top:35 ,left: 35),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Dalal ak jamm,",
                      style: TextStyle(fontSize: 15, color: myColor1),
                    ),
                    Text(
                      'Aissatou seye',
                      style: GoogleFonts.bebasNeue(fontSize: 20 ,color: Colors.black),
                    ),
                  ],
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
              child: Column(
              children: [ 
                ActivityListTile(
                title: 'Running',
                subtitle: 'Build Strong bones by running',
                trailingImage:
                  Image.asset('images/femme.png', height: 170),
                color:  Color.fromRGBO(115, 51, 100, 0.3),
                gradient: Color.fromRGBO(115, 51, 100, 0.7),
              ),
              
              SizedBox(height: 20,),
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
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  icon(width, height, 'images/box.png', 'livraison', context ,myColor),
                  icon(width, height, 'images/home.png', 'Depot', context,myColor),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  icon(width, height, 'images/partners.png', 'Partenaires', context ,myColor),
                  icon(width, height, 'images/money.png', 'Tarif', context,myColor),
                ],
              ),
              SizedBox(height: 40,),
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
              SizedBox(height: 20,),
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
)
          ),
        ],
      ),
     );
  }
}
  
Container icon(double width, double height , String path ,String text ,BuildContext context ,Color color) {
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
        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(40,0,81,0.7)),
        
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
