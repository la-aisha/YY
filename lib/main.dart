import 'package:flutter/material.dart';
import 'package:yy/provider/auth_provider.dart';
import 'package:yy/screen/RegisterCostumer.dart';
import 'package:yy/screen/RegisterDriver.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:yy/screen/Welcome.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        //home: OnboardScreen(),
        //home: show ? IntroScreen() :  Welcome(),
        // home: RepositoryProvider(create: (context) => AppRepository(),r

        // child: SignIn(),
        //home: Welcome(role_id: 0) ,
        home: Welcome() ,
      ),
    );
  }
}
