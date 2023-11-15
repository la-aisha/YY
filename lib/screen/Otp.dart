import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart' as pc;
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:yy/methods/common_methods.dart';
import 'package:yy/provider/auth_provider.dart';
import 'package:yy/screen/ScreenCustomer/HomeScreenCustomer.dart';
import 'package:yy/screen/ScreenCustomer/InformationCustomer.dart';
import 'package:yy/screen/ScreenDriver.dart/HomeScreenDriver.dart';
import 'package:yy/screen/ScreenDriver.dart/InformationDriver.dart';
import 'package:yy/widgets/custom_button.dart';

import '../model/user_model.dart';
import '../utils/utils.dart';

class Otp extends StatefulWidget {
  final String verificationId;
  UserModel? user;

  Otp({super.key, required this.verificationId, this.user});

  @override
  State<Otp> createState() => _OtpState(userModel: this.user);
}

class _OtpState extends State<Otp> {
  UserModel? userModel;

  _OtpState({this.userModel});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(userModel?.phoneNumber);
    // print(patient.address);
  }

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  bool _isObscure = true;
  bool _isObscure3 = true;
  bool isChecked = false;
  String otpPin = "";
  String countryDial = "+221";
  String verID = " ";
  int screenState = 0;

  String? otpCode;
  CommonMethods cMethods = CommonMethods();

  checkNetworkAvaible() {
    cMethods.checkConnectivity(context);
    verifyOtp(context, otpCode!);
    print(true);
  }

  void showSnackBarText(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void verifyOtp(BuildContext context, String userOtp,
      {bool isDriver = false}) {
    final ap = Provider.of<MyAuthProvider>(context, listen: false);
    UserModel user = UserModel(
        firstname: '',
        lastname: "",
        createdAt: "",
        phoneNumber: userModel!.phoneNumber,
        uid: "");

    Function onSuccess = () {
      // checking whether user exists in the db
      ap.checkExistingUser().then((value) {
        if (value == true) {
          // user exists in our app
          ap.getDataFromFirestore().then((value) {
            ap.saveUserDataToSP().then((value) {
              ap.setSignIn().then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Homescreencustomer(),
                    ),
                    (route) => false);
              });
            });
          });
        } else {
          print('la valeur de phone est ${user?.phoneNumber}');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => InformationCustomer(user: user)),
              (route) => false);
        }
      });
    };

    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: onSuccess,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isloading =
        Provider.of<MyAuthProvider>(context, listen: true).isLoading;
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    Widget stateOTP() {
      return Container(
          width: width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Verification",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Enter the OTP sent to your phone number ${userModel!.phoneNumber}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black38,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              //const SizedBox(height: ),
              SizedBox(
                height: 50,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color.fromRGBO(40, 0, 81, 1)),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onCompleted: (value) {
                  setState(() {
                    otpCode = value;
                  });
                  print(otpCode);
                },
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: CustomButton(
                  text: "Verify",
                  onPressed: () {
                    print(otpCode);
                    if (otpCode != null) {
                      //storeData();
                      checkNetworkAvaible();
                      //if(verifyOtp(context, otpCode)){
                    } else {
                      showSnackBar(context, "Enter 6-Digit code");
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Didn't receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Resend New Code",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(189, 22, 22, 1),
                ),
              ),
            ],
          ));
    }

    return Scaffold(
      body: Container(
        child: isloading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    logoContainer(),
                    /* Padding(padding: EdgeInsets.only(left: width/10),
            child:  */
                    SizedBox(height: 30),
                    Center(),
                    stateOTP(),
                  ],
                ),
              ),
      ),
    );
  }

  Center logoContainer() {
    return Center(
        child: Column(
      children: [
        Image.asset('images/yobal.png', width: 50, height: 50),
        Text(
          'Inscription',
          style: GoogleFonts.breeSerif(
            textStyle: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(40, 0, 81, 1),
              fontWeight: FontWeight.bold,
              decorationColor: Color.fromRGBO(40, 0, 81, 1),
            ),
          ),
        ),
      ],
    )

        // height: 100, width: 208, child: Image.asset('images/yobal.png')),
        );
  }

/* ---- champs text --- */

  TextField textfield(
      {required String placeHolder,
      bool isHide = false,
      controller,
      TextInputType? textInputType}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelStyle: GoogleFonts.poppins(
            fontSize: 16,
            color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
          hintText: placeHolder,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xFF1E3148),
                width: 3.0,
              ))),
      obscureText: isHide,
      keyboardType: textInputType,
    );
  }

  TextField textfieldnumber(
      {required String placeHolder,
      bool isHide = false,
      controller,
      TextInputType? textInputType}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Telephone',
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/flags/sn.png', // Replace with the path to the Senegal flag image
            package: 'intl_phone_number_input',
            height: 24,
            width: 24,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Color(0xFF1E3148),
            width: 3.0,
          ),
        ),
        hintText: placeHolder,
      ),
      obscureText: isHide,
      keyboardType: textInputType,
    );
  }
}
