import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterDriver extends StatefulWidget {
  const RegisterDriver({super.key});

  @override
  State<RegisterDriver> createState() => _RegisterDriverState();
}

class _RegisterDriverState extends State<RegisterDriver> {
  bool _isObscure = true;
  bool _isObscure3 = true;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: width * 0.8,
                    height: 35,
                    child: welcomeText(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: width * 0.8,
                    height: 35,
                    child: textfield(
                        placeHolder: 'Prenom',
                        //controller: firstNameController,
                        isHide: false,
                        textInputType: TextInputType.name),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                    width: width * 0.8,
                    height: 35,
                    child: textfield(
                        placeHolder: 'Nom',
                        //controller: firstNameController,
                        isHide: false,
                        textInputType: TextInputType.name),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                    width: width * 0.8,
                    height: 35,
                    child: textfield(
                        placeHolder: 'Telephone',
                        //controller: firstNameController,
                        isHide: false,
                        textInputType: TextInputType.number),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  /*
                  Container(
                      width: width * 0.8, height: 35, child: textfieldmdp()),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                      width: width * 0.8, height: 35, child: textfieldmdp2()),
                  SizedBox(
                    height: 12,
                  ), */
                  Container(width: width * 0.8, height: 35, child: check()),
                  SizedBox(
                    height: 30,
                  ),
                  Container(width: width * 0.8, height: 35, child: register()),
                  SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      "Deja inscrit ?",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(0, 0, 0, 0.45),
                          fontSize: 13,
                          fontStyle: FontStyle.normal),
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
                            fontStyle: FontStyle.normal),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ]),
                  // Spacer(),
                ],
              ),
              SizedBox(height: height / 8),
              Container(
                  width: width * 0.8,
                  height: 35,
                  child: registerGoogle(
                    path: 'images/googleLogo.png',
                    text: "Continuer avec Google",
                  )),
            ],
          ),
        ),
      ),
    );
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

  ElevatedButton register() {
    return ElevatedButton(
        onPressed: () {},
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
        'BIENVENUE CONVOYEUR,',
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
