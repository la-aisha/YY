import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart' as pc;
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:yy/methods/common_methods.dart';
import 'package:yy/provider/auth_provider.dart';
import 'package:yy/screen/ScreenCustomer/HomeScreenCustomer.dart';
import 'package:yy/utils/utils.dart';
import 'package:yy/widgets/custom_button.dart';
import '../model/user_model.dart';

class RegisterCostumer extends StatefulWidget {
  UserModel user;
  RegisterCostumer({super.key, required this.user});
  @override
  State<RegisterCostumer> createState() => _RegisterCostumerState(user: user);
}

class _RegisterCostumerState extends State<RegisterCostumer> {
  UserModel user;
  _RegisterCostumerState({required this.user});

  Color myColor1 = Color.fromRGBO(40, 0, 81, 1);
  Color myColor2 = Color.fromRGBO(189, 22, 22, 1);

  /* ----- les controllers */
  TextEditingController phoneController = new TextEditingController();
  CommonMethods cMethods = CommonMethods();

  bool isChecked = false;
  String otpPin = "";
  String countryDial = "+221";
  String verID = " ";

  void sendphonenumber() {
    final ap = Provider.of<MyAuthProvider>(context, listen: false);
    String phonenumber = countryDial + phoneController.text.trim();
    ap.signInWithPhone(context, phonenumber, user);
    print(phonenumber);
    print(" REGISTER${user.phoneNumber}");
  }

  checkNetworkAvaible() {
    cMethods.checkConnectivity(context);
    sendphonenumber();
    print(true);
    user.phoneNumber = phoneController.text.trim();
    print('the user phone${user.phoneNumber}');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    Widget stateRegister() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: width * 0.8,
            height: 35,
            child: welcomeText(),
          ),
          SizedBox(height: 30),
          /* Container(
            width: width * 0.8,
            height: 35,
            child: textfield(
              placeHolder: 'Prenom',
              controller: firstNameController,
              isHide: false,
              textInputType: TextInputType.name,
            ),
          ),
          SizedBox(height: 18),
          Container(
            width: width * 0.8,
            height: 35,
            child: textfield(
              placeHolder: 'Nom',
              controller: lastNameController,
              isHide: false,
              textInputType: TextInputType.name,
            ),
          ), */
          SizedBox(height: 18),
          Container(
            width: width * 0.8,
            height: 35,
            child: txtphone(),
          ),
          SizedBox(height: 20),
          Container(width: width * 0.8, height: 35, child: check()),
          SizedBox(height: 30),
          Container(width: width * 0.8, height: 35, child: register()),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Deja inscrit ?",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(0, 0, 0, 0.45),
                  fontSize: 13,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () {
                  /* final OTP = Otp();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext ctx) {
                  return OTP;
                })); */
                },
                child: Text(
                  "Se connecter?",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(189, 22, 22, 1),
                    fontSize: 13,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: height / 8),
          Container(
            width: width * 0.8,
            height: 35,
            child: registerGoogle(
              path: 'images/googleLogo.png',
              text: "Continuer avec Google",
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              logoContainer(),
              /* Padding(padding: EdgeInsets.only(left: width/10),
              child:  */
              SizedBox(height: 30),
              Center(),
              stateRegister()
            ],
          ),
        ),
      ),
    );
  }

  TextFormField txtphone() {
    return TextFormField(
      cursorColor: Colors.purple,
      controller: phoneController,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      /* onChanged: (value) {
        setState(() {
          phoneController.text = value;
        });
      }, */
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(1),
        hintText: "Enter phone number",
        hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.grey.shade600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(3),
          child: Image.asset(
            'assets/flags/sn.png', // Replace with the path to the Senegal flag image
            package: 'intl_phone_number_input',
            height: 10,
            width: 10,
          ),
        ),
        suffixIcon: phoneController.text.length > 9
            ? Container(
                height: 30,
                width: 30,
                margin: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: const Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 20,
                ),
              )
            : null,
      ),
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
        hoverColor: myColor1,
        fillColor: myColor1,
        focusColor: myColor1,
        labelText: 'Telephone',
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 5.0),
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

  ElevatedButton register() {
    return ElevatedButton(
        onPressed: () {
          if (phoneController.text.isEmpty || phoneController.length != 9) {
            showSnackBar(context, "Phone number is not correct!");
          } else if (isChecked == false) {
            showSnackBar(context, "Accept condition!");
          } else {
            //sendphonenumber();
            checkNetworkAvaible();
          }

          //print('registerscreen');
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
      onPressed: () {
        final provider = Provider.of<MyAuthProvider>(context, listen: false);
        //provider.googleLogin();
      },
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
            print(value);
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
        contentPadding: EdgeInsets.all(20.0),
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
