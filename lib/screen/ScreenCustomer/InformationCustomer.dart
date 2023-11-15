import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yy/methods/common_methods.dart';
import 'package:yy/model/user_model.dart';
import 'package:yy/provider/auth_provider.dart';
import 'package:yy/screen/ScreenCustomer/HomeScreenCustomer.dart';
import 'package:yy/widgets/custom_button.dart';

class InformationCustomer extends StatefulWidget {
  UserModel user;
  InformationCustomer({super.key, required this.user});

  @override
  State<InformationCustomer> createState() =>
      _InformationCustomerState(user: user);
}

class _InformationCustomerState extends State<InformationCustomer> {
  UserModel? user;
  _InformationCustomerState({required this.user});
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('-------la valeur de phone est ${user!.phoneNumber}');

    // print(patient.address);
  }

  CommonMethods cMethods = CommonMethods();

  checkNetworkAvaible() {
    cMethods.checkConnectivity(context);
    storeData();
    print(true);
    //print(user?.phoneNumber);
  }

  storeData() {
    //print('this is ${user!.phoneNumber}');
    final ap = Provider.of<MyAuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      firstname: firstnameController.text.trim(),
      lastname: lastnameController.text.trim(),
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      phoneNumber: user!.phoneNumber,
      uid: user!.phoneNumber,
    );
    print(userModel.firstname);
    ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        //profilePic: image!,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Homescreencustomer(),
                          ),
                          (route) => false),
                    ),
              );
        },
        onFailure: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Row(
                  children: [
                    Icon(
                      CupertinoIcons.exclamationmark_circle,
                      color: Colors.red,
                      size: 30,
                    ),
                    SizedBox(width: 8),
                    Text('Danio am erreur'),
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
                    Text('Veillez reessayer plustard'),
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Image.asset('images/yobal.png', width: 50, height: 50),
                SizedBox(
                  height: 100,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      // name field
                      textFeld(
                        hintText: "nom",
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: firstnameController,
                      ),
                      textFeld(
                        hintText: "prenom",
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: lastnameController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: CustomButton(
                    text: "Continue",
                    onPressed: () => checkNetworkAvaible(),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Color.fromRGBO(28, 0, 51, 0.2),
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20.0),
          labelStyle: GoogleFonts.poppins(
            fontSize: 16,
            color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // color: Colors.purple,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Color(0X280051),
            ),
          ),
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
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          //fillColor: Colors.purple.shade50,
          filled: true,
        ),
      ),
    );
  }
}
