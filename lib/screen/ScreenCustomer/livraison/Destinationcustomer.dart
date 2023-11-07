import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:yy/global/global_var.dart';
import 'package:yy/screen/RegisterCostumer.dart';

class DestinationCustomer extends StatefulWidget {
  const DestinationCustomer({Key? key}) : super(key: key);

  @override
  State<DestinationCustomer> createState() => _DestinationCustomerState();
}

class _DestinationCustomerState extends State<DestinationCustomer> {
  final Completer<GoogleMapController> googleMapCompleterController =
      Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double width = size.width;
    var height = size.height;

    final departController = new TextEditingController();
    final arriveController = new TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: googlePlexInitialPosition,
            onMapCreated: (GoogleMapController mapController) {
              controllerGoogleMap = mapController;
              googleMapCompleterController.complete();
            },
          ),
          Positioned.fill(child: DraggableScrollableSheet(
            builder: (_, controller) {
              return Stack(
                children: [
                  //Padding(padding: EdgeInsets.only())
                  Container(
                    //width: double.infinity,
                    //height: height/4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Colors.white,
                      gradient:
                          LinearGradient(begin: Alignment.topCenter, colors: [
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
                          minRadius: 20,
                          child: Image.asset(
                            'images/loop.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        //Spacer(),
                        Padding(padding: EdgeInsets.all(5)),
                        Text(
                          'Entrez les positions ...',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
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
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      height: double.infinity,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('images/direction1.png', height: 150),
                            SizedBox(
                              width: 20,
                            ),
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
                                        primary: Color.fromRGBO(40, 0, 81, 0.6),
                                      ),
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: ((context) {
                                              return Container(
                                                height: 400,
                                                width: double.infinity,
                                                //color: Colors.white,
                                                decoration: BoxDecoration(),
                                                child: Text('hello'),
                                              );
                                            }));
                                      },
                                      child: Padding(
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
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 30)),
                                  Container(
                                    width: width * 0.7,
                                    height: 60,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color.fromRGBO(40, 0, 81, 0.6),
                                      ),
                                      onPressed: () {},
                                      child: Padding(
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
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
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

  Widget buildDragHandle() {
    return Center(
      child: Container(
        width: 45,
        height: 3,
        color: Colors.white,
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
          */ /*  enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ), */
          /*  focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ), */
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
