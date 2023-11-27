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
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yy/global/global_var.dart';
import 'package:yy/methods/common_methods.dart';
import 'package:yy/model/choicecar.dart';
import 'package:yy/model/directiondetail_model.dart';
import 'package:yy/model/prediction_model.dart';
import 'package:yy/provider/app_provider.dart';
import 'package:yy/screen/RegisterCostumer.dart';
import 'package:yy/widgets/predictionplace_ui.dart';
//AIzaSyCyQ3HH4EtUSvkw3NsmT6pb0tYbqqv6Iog

class DestinationCustomer extends StatefulWidget {
  const DestinationCustomer({Key? key}) : super(key: key);

  @override
  State<DestinationCustomer> createState() => _DestinationCustomerState();
}

class _DestinationCustomerState extends State<DestinationCustomer> {
  late PersistentBottomSheetController _controller; // <------ Instance variable
  final _scaffoldKey = GlobalKey<ScaffoldState>(); // <---- Another instance variable

  PredictionModel? predictionModel;
  ChoiceCar? choiceCar;
  List<PredictionModel> dropoffPrediction = [];
  TextEditingController departController = new TextEditingController();
  final arriveController = new TextEditingController();
  final Completer<GoogleMapController> googleMapCompleterController = Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;
  Position? currentPositonUser;

  String? SelectedVehiculeType;
  bool defaultcar = false;
  var selected;
  int selectedcarindex = 0;

  DirectionDetail? tripDirectionDetail;


  void barTapedd(int index) {
    setState(() {
      selectedcarindex = index;
    });
    print('selected car index is ${selectedcarindex}');
    // _key.currentState?.reload();
  }

  //intialiser pour eviter les null check

  @override
  void initState() {
    super.initState();
    //CommonMethods.convertGeo(currentPositonUser!, context);
    //startColorChange();
    barTapedd(selectedcarindex);
    //super.initState();
    //departController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    barTapedd(selectedcarindex);
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
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: Container(
                  // color: Colors.amber,
                  child: SingleChildScrollView(
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
                                child: destinationdepart(
                                    departController, 'depart')),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
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
                                  height: 50,
                                  child: destination(
                                    arriveController,
                                    'arrive',
                                  )),
                            ],
                          ),
                        ),
                        //display predicted places
                        (dropoffPrediction.length > 0)
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 5),
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return Card(
                                        surfaceTintColor:
                                            Color.fromARGB(40, 0, 81, 1),
                                        elevation: 0,
                                        child: PredictionPlaceUI(
                                          predictionModel:
                                              dropoffPrediction[index],
                                        ),
                                      );
                                    },
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            SizedBox(height: 2),
                                    itemCount: dropoffPrediction.length),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ],
    );
  }

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

  // la position en live avec geolocator
  /* getCurrentLiveLocationOfUser() async {
    Position positionOfUser = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPositonUser = positionOfUser;
    LatLng positionUser =LatLng(currentPositonUser!.latitude, currentPositonUser!.longitude);
    CameraPosition cameraPosition = CameraPosition(target: positionUser, zoom: 15);
    controllerGoogleMap!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    await CommonMethods.convertGeo(currentPositonUser!, context);
  }  */

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
    var position = await CommonMethods.convertGeo(currentPositonUser!, context);
    print('test sur readable addres${position}');
    // var read = await CommonMethods.convertGeo(currentPositonUser!, context);
  }

  // Google place autocomplete
  searchLocation(String locationName) async {
    if (locationName.length > 1) {
      String apiPlacesUrl =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$locationName&language=fr&types=&key=$googleMapKey&components=country:sn';
/*       'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$locationName&language=fr&types=geocode&key=$googleMapKey&components=country:sn';
 */
      /*  String apiPlacesUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$locationName&language=fr&types=(cities)&key=$googleMapKey&components=country:sn';
      */
      var responsePlace = await CommonMethods.sendRequestToApi(apiPlacesUrl);
      print('prediction test : ${responsePlace['status']}');
      if (responsePlace == "error") {
        return;
      }
      if (responsePlace["status"] == "OK") {
        var predictionlistJson = responsePlace["predictions"];
        var predictionList = (predictionlistJson as List)
            .map((eachplaceprediction) =>
                PredictionModel.fromJson(eachplaceprediction))
            .toList();
        setState(() {
          dropoffPrediction =
                  predictionList /* .where((prediction) => prediction.description!.contains(', SN'))
            .toList() */
              ;
        });
        print('prediction result en json : ${predictionlistJson.toString()}');
        // Print city predictions for Senegal
        for (var prediction in predictionList) {
          print('City: ${prediction.main_text}');
        }
      }
    }
  }

  //direction
  retrieveDirectionDetails() async {
    var pickupLocation =
        Provider.of<AppProvider>(context, listen: false).pickupLocation;
    var dropoflocation =
        Provider.of<AppProvider>(context, listen: false).dropoffLocation;
    //recuper les update coords
    var pickupGeographicCordinates = LatLng(
        pickupLocation!.latitutePosition!, pickupLocation.longitudePosition!);
    var dropffGeographicCordinates = LatLng(
        dropoflocation!.latitutePosition!, dropoflocation.longitudePosition!);

    //show dialog
    /*  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('KHaral touti ....'),
          ],
        ),
      ),
    )
  ); */
    //call direction
    var detailsDirectionApi = await CommonMethods.getdirectionDetailsFromApi(
        pickupGeographicCordinates, dropffGeographicCordinates);
    setState(() {
      print(
          'les coordonnees geographique pour la :${pickupGeographicCordinates},${dropffGeographicCordinates}');
      tripDirectionDetail = detailsDirectionApi;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Afficher la location de l'utilisateur a
     String userAddress = Provider.of<AppProvider>(context, listen: false)
            .pickupLocation!
            .readableAdress ??
        "";
    print('USER ADDRESS ${userAddress}');
    departController.text = userAddress; 

    
  
    var size = MediaQuery.of(context).size;
    double width = size.width;
    var height = size.height;


    Row departarrivedetail() {

    String droppofflocation =
      Provider.of<AppProvider>( context,
      listen: false)
      .dropoffLocation!
      .placeName ??
      "";
    print(
    "dropoffloaction place name  in modal =" +droppofflocation); 

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'images/direction1.png',
          height: 100,
        ),
        SizedBox(
            width:
                16), // Add some space between the image and the first container
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                color: Color.fromRGBO(40, 0, 81, 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Text(
                     userAddress ,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 13,
                    ),
                    //textAlign: TextAlign.ju,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16), // Add some space between the two containers
            Container(
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                color: Color.fromRGBO(40, 0, 81, 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Text(
                    droppofflocation,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 13,
                    ),
                    //textAlign: TextAlign.ju,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  displayUserRideDetailModal(BuildContext context) async {
      await retrieveDirectionDetails();
      //modal bottom sheet
      await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: ((context) => StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.57,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
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
                      child: Column(children: [
                        Padding(padding: EdgeInsets.all(5)),
                        buildDragHandle(),
                        Padding(padding: EdgeInsets.all(3)),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          minRadius: 17,
                          child: Image.asset(
                            'images/tap.png',
                            width: 15,
                            height: 15,
                          ),
                        ),
                        Text(
                          (tripDirectionDetail != null)
                              ? tripDirectionDetail!.distanceTextString!
                              : "",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 70.0),
                      child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          //height: double.infinity,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.55,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 10),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.S,
                                  children: [
                                    //Row position depart et arrivee
                                    departarrivedetail(),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    cars(),
                                    /* SizedBox(
                                      height: 20,
                                    ), */
                                    //Text((tripDirectionDetail != null)? CommonMethods.calculateFareAmount((tripDirectionDetail!)).toString() : "" ,style: GoogleFonts.montserrat(color: Colors.black , fontSize: 20  ,fontWeight: FontWeight.bold),),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                        onTap: () {},
                                        child: Image.asset(
                                          'images/go1.png',
                                          width: 70,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                );
              })));
    }

    //Listview


    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: googlePlexInitialPosition,
            onMapCreated: (GoogleMapController mapController) {
              getCurrentLiveLocationOfUser();
              controllerGoogleMap = mapController;
              //updateMapTheme(controllerGoogleMap!);

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
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: Container(
                                // width: ,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary:
                                                Color.fromRGBO(40, 0, 81, 0.3),
                                            minimumSize: Size(width / 4, 40),
                                            maximumSize: Size(width * 0.7, 40),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20.0), // Border radius
                                            ),
                                            elevation: 0),
                                        onPressed: () async {
                                          var ResponseFromModalPositon =
                                              await showModalBottomSheet(
                                                  //isScrollControlled : true ,
                                                  context: context,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(20.0),
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
                                          if (ResponseFromModalPositon ==
                                              "placeselected") {
                                            /* String droppofflocation =
                                            Provider.of<AppProvider>( context,
                                            listen: false)
                                            .dropoffLocation!
                                            .placeName ??
                                            "";
                                          print(
                                          "dropoffloaction place name  in modal =" +droppofflocation); */
                                            displayUserRideDetailModal(context);
                                          }
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
                                        )
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

  Widget cars() {
    //Text((tripDirectionDetail != null)? CommonMethods.calculateFareAmount((tripDirectionDetail!)).toString() : "" ,style: GoogleFonts.montserrat(color: Colors.black , fontSize: 20  ,fontWeight: FontWeight.bold),),
    var cars = CommonMethods.calculateFareAmount(tripDirectionDetail!);
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
        height: 140,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          //itemCount: choiceCars.length,
          itemCount: cars.length,

          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                  if (mounted) {
                    //barTapedd(index);
                    setState(() {
                      selectedcarindex = index; // Update selected car index
                    });
                    /*  setState(() {
                        
                        //SelectedVehiculeType = choiceCars[index].type;
                        // You can also update other state variables here if needed
                        // defaultcar = (SelectedVehiculeType == 'taxi');
                      }); */
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 1 / 3,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: (selectedcarindex == index)
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            colors: [
                              Color.fromRGBO(40, 0, 81, 0.2),
                              Color.fromRGBO(40, 0, 81, 0.2),
                            ],
                          )
                        : LinearGradient(
                            begin: Alignment.topLeft,
                            colors: [
                              Color.fromRGBO(40, 0, 81, 0.1),
                              Color.fromRGBO(40, 0, 81, 0),
                            ],
                          ),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset('images/carchoice1.png'),
                        Text(
                          cars[index].type.toString(),
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          cars[index].prix.toString(),
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
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

  Widget destinationdepart(
    TextEditingController controller,
    String hintText,
  ) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            fillColor: Color.fromRGBO(40, 0, 81, 0.3),
            isDense: true,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
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

  Widget destination(
    TextEditingController controller,
    String hintText,
  ) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (inputText) {
          searchLocation(inputText);
        },
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            fillColor: Color.fromRGBO(40, 0, 81, 0.3),
            isDense: true,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
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
