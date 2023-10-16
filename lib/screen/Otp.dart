import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart' as pc;
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:yy/provider/auth_provider.dart';
import 'package:yy/screen/ScreenCustomer/HomeScreenCustomer.dart';
import 'package:yy/widgets/custom_button.dart';

import '../model/user_model.dart';
import '../utils/utils.dart';

class Otp extends StatefulWidget {
  final String verificationId;
  UserModel user;

  Otp({super.key, required this.verificationId, required this.user});

  @override
  State<Otp> createState() => _OtpState(user: this.user);
}

class _OtpState extends State<Otp> {
  UserModel user;

  _OtpState({required this.user});

  /* ----- les controllers */

  //recuperer le code

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(user.lastname);
    // print(patient.address);
  }

  UserModel? _userModel;

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

  void sendphonenumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phonenumber = countryDial + phoneController.text.trim();
    ap.signInWithPhone(context, phonenumber, user);
    print(phonenumber);
    //print(user.firstname);
  }

  void showSnackBarText(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  // store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      firstname: firstNameController.text.trim(),
      lastname: lastNameController.text.trim(),
      createdAt: "",
      phoneNumber: phoneController.text,
      uid: "",
      //firstname: '',
      //lastname: '',
    );
    // if (image != null) {
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
    );
    /*  } else {
      showSnackBar(context, "Please upload your profile photo");
    } */
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db
        ap.checkExistingUser().then(
          (value) async {
            if (value == true) {
              // user exists in our app
              /* ap.getDataFromFirestore().then(
                    (value) => ap.saveUserDataToSP().then(
                          (value) => ap.setSignIn().then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                    (route) => false),
                              ),
                        ),
                  ); */
            } else {
              // new user
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Homescreencustomer()),
                  (route) => false);
            }
          },
        );
      },
    ); //
  }

  @override
  Widget build(BuildContext context) {
    final isloading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    print("otp");
    print(user.firstname);

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
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Enter the OTP sent to your phone number $countryDial${phoneController.text}",
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
                      verifyOtp(context, otpCode!);

                      storeData();
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
        child: SingleChildScrollView(
          child: isloading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                )
              : Column(
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

  ElevatedButton register() {
    return ElevatedButton(
        onPressed: () {
          if (screenState == 0) {
            /*  if (firstNameController.text.isEmpty ||
                lastNameController.text.isEmpty) {
              showSnackBarText("Username is still empty!");
            } else if (phoneController.text.isEmpty) {
              showSnackBarText("Phone number is still empty!");
            } else {
              verifyNumber(countryDial + phoneController.text);
              print('$countryDial${phoneController.text}');
            } */
            sendphonenumber();
          } else {
            /* if (otpPin.length >= 6) {
              verifyOTP();
            } else {
              showSnackBarText("Enter OTP correctly!");
            } */
          }
        },
        child: Text('Inscription',
            style: GoogleFonts.breeSerif(
              textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            )),
        style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(189, 22, 22, 1),
          // Background color
          onPrimary: Colors.white, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Border radius
          ),
          elevation: 3.0, // Button shadow,
        ));
  }

  ElevatedButton registerGoogle(
      {String? path, required String text, IconData? icon}) {
    return ElevatedButton(
      onPressed: () {},
      child: Row(
        children: [
          Image.asset(
            '$path',
            width: 23,
            height: 23,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color(0xFF1E3148), width: 2),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.white)),
    );
  }

  TextField textfieldmdp() {
    return TextField(
      obscureText: _isObscure,
      decoration: InputDecoration(
          hintText: 'Mot de passe',
          labelStyle: GoogleFonts.poppins(
            fontSize: 16,
            color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xFF1E3148),
                width: 3.0,
              )),
          //labelText: 'Password',
          // this button is used to toggle the password visibility
          suffixIcon: IconButton(
              icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off,
                  color: Color(0xFFBD1616)),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              })),
    );
  }

  Row check() {
    return Row(
      children: [
        Checkbox(
          checkColor:
              isChecked ? Colors.white : null, // Red background when checked
          activeColor: Colors.red,
          //hoverColor: Color.fromRGBO(40, 0, 81, 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),

          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
        ),
        Text(
          'J\'accepte les conditions.',
          style: TextStyle(
            color: Colors.black, // Adjust text color as needed
          ),
        ),
      ],
    );
  }

  TextField textfieldmdp2() {
    return TextField(
      obscureText: _isObscure,
      decoration: InputDecoration(
          hintText: 'Mot de passe',
          labelStyle: GoogleFonts.poppins(
            fontSize: 16,
            color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xFF1E3148),
                width: 3.0,
              )),
          //labelText: 'Password',
          // this button is used to toggle the password visibility
          suffixIcon: IconButton(
              icon: Icon(
                _isObscure3 ? Icons.visibility : Icons.visibility_off,
                color: Color(0xFFBD1616),
              ),
              onPressed: () {
                setState(() {
                  _isObscure3 = !_isObscure3;
                });
              })),
    );
  }
}

Row welcomeText() {
  return Row(
    children: [
      Text(
        'BIENVENUE CLIENT,',
        style: GoogleFonts.breeSerif(
          fontWeight: FontWeight.w700,
          color: Color(0xFFBD1616),
          fontSize: 15,
          decoration: TextDecoration.underline,
          decorationColor: Color(0xFFBD1616),
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        'Pret ?',
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w700,
          color: Color.fromRGBO(40, 0, 81, 1),
          fontSize: 15,
        ),
        textAlign: TextAlign.center,
      ),
    ],
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
