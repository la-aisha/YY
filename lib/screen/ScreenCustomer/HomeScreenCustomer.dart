import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yy/provider/auth_provider.dart';

class Homescreencustomer extends StatefulWidget {
  const Homescreencustomer({super.key});

  @override
  State<Homescreencustomer> createState() => _HomescreencustomerState();
}

class _HomescreencustomerState extends State<Homescreencustomer> {
  @override
  Widget build(BuildContext context) {
    //final user = FirebaseAuth.instance.currentUser;
    final ap = Provider.of<AuthProvider>(context, listen: false);
    /* return Container(
      color: Colors.blue,
      child : Column(
        children: [
          Text(ap.userModel.firstname),
         Text(ap.userModel.lastname),
          Text(ap.userModel.phoneNumber),



        ],
      )
    ); */
    return Scaffold(
      body: Container(
         height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromRGBO(40, 0, 81, 1),
             //Color.fromRGBO(115, 51, 100, 1),
              Color.fromRGBO(115, 51, 100, 1),
              Color.fromRGBO(115, 51, 100, 1),

            ]
            
          ),
          
        ),
        child: SingleChildScrollView(
          child: Column(
            
          ),
        ),
      )
    );
  }
}
