import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:yy/global/global_var.dart';
import 'package:yy/model/address_model.dart';
import 'package:yy/provider/app_provider.dart';

class CommonMethods {
  //verifier la connection internet
  Future<void> checkConnectivity(BuildContext context) async {
    var connectionResult = await Connectivity().checkConnectivity();
    if (connectionResult != ConnectivityResult.mobile &&
        connectionResult != ConnectivityResult.wifi) {
      // Handle no connectivity case
      if (!context.mounted) return;
      displayAlert(context);
    } else {
      // Handle connectivity case
    }
  }

  //alert message pour connection
  void displayAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Row(
            children: [
              Icon(
                CupertinoIcons.exclamationmark_circle,
                color: Colors.red,
                size: 30,
              ),
              SizedBox(width: 8),
              Text('Amoulo Connection'),
            ],
          ),
          content: Column(
            children: [
              SizedBox(height: 16),
              Image.asset(
                'images/connection.png',
                height: 100,
                width: 100,
              ),
              SizedBox(height: 16),
              Text('Veillez vérifier votre connexion internet'),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void displaySnackbar(String messageText, BuildContext context) {
    var snackBar = SnackBar(content: Text(messageText));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static sendRequestToApi(String apiUrl) async {
    http.Response responseApi = await http.get(Uri.parse(apiUrl));
    try {
      if (responseApi.statusCode == 200) {
        var data = responseApi.body;
        var dataDecode = jsonDecode(data);
        return dataDecode;
      } else {
        return "error";
      }
    } catch (errorMsg) {
      return "error";
    }
  }

  //Utilise la fonction send request qui ne doit pas renvoyer d'erreur
  static Future convertGeo(Position position, BuildContext context) async {
    String readableAdress = "";
    String apiGeodingUrl =
    'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleMapKey';
    var responseAPI = await sendRequestToApi(apiGeodingUrl);
    if (responseAPI != 'error') {
      readableAdress = responseAPI['results'][0]['formatted_address'];
      print('readable address :${readableAdress}');
      AddressModel address = AddressModel();
      address.readableAdress = readableAdress;
      address.latitutePosition = position.latitude;
      address.longitudePosition = position.longitude;
      Provider.of<AppProvider>(context ,listen: false).updatePickupLocation(address);
    }
    return readableAdress;
  }
}
/* 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var commonMethods = CommonMethods();
  runApp(MyApp(commonMethods: commonMethods));
} */

/* class MyApp extends StatelessWidget {
  final CommonMethods commonMethods;

  const MyApp({Key? key, required this.commonMethods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Connectivity Demo'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            // Assign the context to a local variable
            commonMethods.checkConnectivity(context);
            return Center(
              child: ElevatedButton(
                child: Text('Show Dialog'),
                onPressed: () {
                  commonMethods.displayAlert(context);
                },
              ),
            );
          },
        ),
      ),
    );
  }
} */