import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonMethods {
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
  void displayAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Row(
            children: [
              Icon(
                CupertinoIcons.exclamationmark_circle,
                color: Colors.red,
                size: 40,
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