import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:yy/global/global_var.dart';
import 'package:yy/methods/common_methods.dart';
import 'package:yy/screen/RegisterCostumer.dart';
//AIzaSyCyQ3HH4EtUSvkw3NsmT6pb0tYbqqv6Iog

class DestinationCustomer extends StatefulWidget {
  const DestinationCustomer({Key? key}) : super(key: key);

  @override
  State<DestinationCustomer> createState() => _DestinationCustomerState();
}

class _DestinationCustomerState extends State<DestinationCustomer> {
  final departController = new TextEditingController();
  final arriveController = new TextEditingController();
  final Completer<GoogleMapController> googleMapCompleterController =
      Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;
  Position? currentPositonUser;

  void updateMapTheme(GoogleMapController controller) {
    getJsonFileFromThemes("themes/retro_style.json")
        .then((value) => setGoogleMapStyle(value, controller));
  }

  Future<String> getJsonFileFromThemes(String mapStylePath) async {
    ByteData byteData = await rootBundle.load(mapStylePath);
    var list = byteData.buffer
        .asInt8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return utf8.decode(list);
  }

  setGoogleMapStyle(String googleMapStyle, GoogleMapController controller) {
    controller.setMapStyle(googleMapStyle);
  }

  getCurrentLiveLocationOfUser() async {
    Position positionOfUser = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPositonUser = positionOfUser;
    LatLng positionUser =
        LatLng(currentPositonUser!.latitude, currentPositonUser!.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: positionUser, zoom: 15);
    controllerGoogleMap!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    await CommonMethods.convertGeo(currentPositonUser!, context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double width = size.width;
    var height = size.height;

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: googlePlexInitialPosition,
            onMapCreated: (GoogleMapController mapController) {
              controllerGoogleMap = mapController;
              //updateMapTheme(controllerGoogleMap!);
              getCurrentLiveLocationOfUser();
              //await CommontMethod
              googleMapCompleterController.complete(controllerGoogleMap);
            },
          ),
          Positioned.fill(
              //height :400 ,
              top: height * 0.5,
              child: DraggableScrollableSheet(
                builder: (_, controller) {
                  return Stack(
                    children: [
                      //Padding(padding: EdgeInsets.only())
                      Container(
                        //width: double.infinity,
                        //height: height/4,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              colors: [
                                Color.fromRGBO(40, 0, 81, 1),
                                //Color.fromRGBO(115, 51, 100, 1),
                                Color.fromRGBO(115, 51, 100, 1),
                                Color.fromRGBO(115, 51, 100, 1),
                              ]),
                        ),
                        child: Column(
                          children: [
                            const Padding(padding: EdgeInsets.all(5)),
                            buildDragHandle(),
                            const Padding(padding: EdgeInsets.all(5)),

                            CircleAvatar(
                              backgroundColor: Colors.white,
                              minRadius: 13,
                              child: Image.asset(
                                'images/loop.png',
                                width: 20,
                                height: 20,
                              ),
                            ),
                            //Spacer(),
                            Padding(padding: EdgeInsets.all(5)),
                            /* Text(
                          'Entrez les positions ...',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ), */
                            Padding(padding: EdgeInsets.all(2)),
                            /*  Text(
                          'lieu de depart et lieu d arrivee',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 9,
                            // decoration: TextDecoration.underline,
                            //decorationColor: Color(0xFFBD1616),
                          ),
                          textAlign: TextAlign.center,
                        ), */
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 70.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          // height: double.infinity,
                          width: double.infinity,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: /* Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('images/direction1.png', height: 150),
                            SizedBox(
                              width: 20,
                            ), */
                                  Container(
                                // width: ,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: width * 0.7,
                                      height: 60,
                                      //color: Color.fromRGBO(40, 0, 81, 10),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Color.fromRGBO(
                                                  40, 0, 81, 0.3),
                                              elevation: 0),
                                          onPressed: () {
                                            showModalBottomSheet(
                                                //isScrollControlled : true ,
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(20.0),
                                                  ),
                                                ),
                                                builder: ((context) {
                                                  return Container(
                                                    height:
                                                        height, // set the height to 7/10 of the screen height
                                                    //child: modalCourse(width ,height/2)
                                                    child: modalPosition(
                                                        width, height),
                                                  );
                                                }));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'voulez vous etre livre ? ',
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Image.asset(
                                                'images/send.png',
                                                height: 20,
                                              ),
                                            ],
                                          )
                                          /*  Padding(
                                        padding: const EdgeInsets.only(left: 2),
                                        child: Text(
                                          'lieu de depart ',
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                          //textAlign: TextAlign.end,
                                        ),
                                      ), */
                                          ),
                                    ),
                                  ],
                                ),
                              )
                              /*   ],
                        ), */
                              ),
                        ),
                      ),
                    ],
                  );
                },
              )),
        ],
      ),
    );
  }

  Widget modalCourse(double width, double height) {
    return Stack(
      children: [
        //Padding(padding: EdgeInsets.only())
        Container(
          //width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color.fromRGBO(40, 0, 81, 1),
              //Color.fromRGBO(115, 51, 100, 1),
              Color.fromRGBO(115, 51, 100, 1),
              Color.fromRGBO(115, 51, 100, 1),
            ]),
          ),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(5)),
              buildDragHandle(),
              Padding(padding: EdgeInsets.all(3)),
              CircleAvatar(
                backgroundColor: Colors.white,
                minRadius: 17,
                child: Image.asset(
                  'images/send.png',
                  width: 15,
                  height: 15,
                ),
              ),
              //Spacer(),
              Padding(padding: EdgeInsets.all(5)),
              Padding(padding: EdgeInsets.all(2)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            //height: double.infinity,
            width: double.infinity,
            child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Image.asset(
                              'images/d2.png',
                              height: 50,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            // color: Colors.yellow,
                            width: 300, height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // TextFormField() ,
                                // TextFormField(),
                              ],
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          // controller: ,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              color: Colors.amber,
                              //child: ,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              color: Colors.red,
                              //child: ,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              color: Colors.black,
                              //child: ,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              color: Colors.amber,
                              //child: ,
                            )
                          ],
                        ),
                        //listview de container
                      ),
                      //Padding(padding: EdgeInsets.only(top: 100)),
                      Container(
                        color: Colors.amber,
                        width: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Image.asset(
                            "images/go1.png",
                            width: 60,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }

  Widget modalPosition(double width, double height) {
    return Stack(
      children: [
        //Padding(padding: EdgeInsets.only())
        Container(
          //width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color.fromRGBO(40, 0, 81, 1),
              //Color.fromRGBO(115, 51, 100, 1),
              Color.fromRGBO(115, 51, 100, 1),
              Color.fromRGBO(115, 51, 100, 1),
            ]),
          ),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(5)),
              buildDragHandle(),
              Padding(padding: EdgeInsets.all(3)),
              CircleAvatar(
                backgroundColor: Colors.white,
                minRadius: 17,
                child: Image.asset(
                  'images/send.png',
                  width: 15,
                  height: 15,
                ),
              ),
              //Spacer(),
              Padding(padding: EdgeInsets.all(5)),
              Padding(padding: EdgeInsets.all(2)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70.0),
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              //height: double.infinity,
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Container(
                  // color: Colors.amber,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('images/d2.png', height: 30),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              //color: Colors.yellow,
                              width: width * 0.75,
                              height: 50,
                              child: destination(departController, 'depart')),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('images/d1.png', height: 30),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              //color: Colors.yellow,
                              width: width * 0.75,
                              height: 110,
                              child: destination(arriveController, 'arrive')),
                        ],
                      ),
                    ],
                  ),
                  /*  child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          
                        ),
                       /*  Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('images/d2.png', height: 30),
                          ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              //color: Colors.yellow,
                              width: width * 0.75 ,height: 110,
                              child:destination(departController, 'depart')
                            ),
                          ],
                        ), 
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('images/d1.png', height: 30),
                          ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              //color: Colors.yellow,
                              width: width * 0.75 ,height: 110,
                              child:destination(arriveController, 'arrive')
                                  
                            ),
                            
                          ],
                  
                        ), 
                        //listview de container */
                      ],
                    ),
                  */
                ),
              )),
        ),
      ],
    );
  }

  Widget buildDragHandle() {
    return Center(
      child: Container(
        width: 45,
        height: 3,
        color: Colors.white,
      ),
    );
  }

  Widget destination(TextEditingController controller, String hintText) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            fillColor: Color.fromRGBO(40, 0, 81, 0.3),
            isDense: true,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget textFeld({
    required String hintText,
    //required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        // cursorColor: Colors.purple,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          /* prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            /* decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromRGBO(40, 0, 81, 0.5),
            ), */
            /* child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ), */
          ),
          */
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.purple,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          //fillColor: Colors.purple.shade50,
          //filled: true,
        ),
      ),
    );
  }
}
