import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yy/provider/auth_provider.dart';
import 'package:yy/screen/RegisterCostumer.dart';
import 'package:yy/screen/RegisterDriver.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:yy/screen/ScreenCustomer/Becomedriver.dart';
import 'package:yy/screen/ScreenCustomer/HomeScreenCustomer.dart';
import 'package:yy/screen/ScreenCustomer/livraison/Destinationcustomer.dart';
import 'package:yy/screen/SplashScreen.dart';
import 'package:yy/screen/Welcome.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  final showOnboarding = prefs.getBool('ON_BOARDING') ?? true;
  /*  await Permission.locationWhenInUse.isDenied.then((valueOfPermission) {
    if (valueOfPermission) {
      Permission.locationWhenInUse.request();
    }
  }); */
  runApp(App(showOnboarding: showOnboarding));
}

class App extends StatelessWidget {
  final bool showOnboarding;
  const App({Key? key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      // ...
      home: Welcome(),
    ),
  );
}
}
