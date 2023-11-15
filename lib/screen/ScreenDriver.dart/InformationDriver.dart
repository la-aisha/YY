import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yy/methods/common_methods.dart';
import 'package:yy/model/car_model.dart';
import 'package:yy/model/convoyeur_model.dart';
import 'package:yy/model/user_model.dart';
import 'package:yy/provider/auth_provider.dart';
import 'package:yy/screen/ScreenCustomer/HomeScreenCustomer.dart';
import 'package:yy/screen/ScreenDriver.dart/HomeScreenDriver.dart';
import 'package:yy/utils/utils.dart';
import 'package:yy/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:yy/widgets/buttonwidget.dart';

class InformationDriver extends StatefulWidget {
  UserModel user;
  InformationDriver({required this.user});

  @override
  State<InformationDriver> createState() => _InformationDriverState(user: user);
}

class _InformationDriverState extends State<InformationDriver> {
  UserModel user;
  _InformationDriverState({required this.user});
  int currentStep = 0;
  Color myCustomColor = Color.fromRGBO(40, 0, 81, 1);
  bool isCompleted = false;
  Color myColor1 = Color.fromRGBO(40, 0, 81, 1);
  Color myColor2 = Color.fromRGBO(189, 22, 22, 1);

  UploadTask? task;

  CommonMethods commonMethods = CommonMethods();

  checkNetworkAvaibility() {
    commonMethods.checkConnectivity(context);
    storeData();
  }

  File? cartegrise;
  File? controletechnique;
  File? permisconduire;
  File? imagevehicule;
  File? imageConducteur;

  final nomvehiculeController = TextEditingController();
  final typeController = TextEditingController();
  final immatriculationController = TextEditingController();

  final addressController = TextEditingController();
  final emailController = TextEditingController();

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nomvehiculeController.dispose();
    typeController.dispose();
    immatriculationController.dispose();
    addressController.dispose();
    emailController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
  }

  void selectImage() async {
    imageConducteur = await pickImage(context);
    setState(() {});
  }

  void selectImageVehicule() async {
    imagevehicule = await pickImage(context);
    setState(() {});
  }

  void selectImageP() async {
    permisconduire = await pickImage(context);
    setState(() {});
  }

  void selectImagecg() async {
    cartegrise = await pickImage(context);
    setState(() {});
  }

  void selectImagect() async {
    controletechnique = await pickImage(context);
    setState(() {});
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep >= 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text('Infos'),
          content: Container(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    selectImage();
                  },
                  child: imageConducteur == null
                      ? CircleAvatar(
                          child: Image.asset(
                            'images/driver2.png',
                            width: 60,
                            height: 60,
                          ),
                          //backgroundColor: Colors.,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(imageConducteur!),
                          radius: 60,
                        ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      textFeld(
                        hintText: "nom",
                        icon: Icons.person_2,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: firstnameController,
                      ),
                      textFeld(
                        hintText: "prenom",
                        icon: Icons.person_2,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: lastnameController,
                      ),
                      // name field
                      textFeld(
                        hintText: "address",
                        icon: Icons.home_rounded,
                        inputType: TextInputType.text,
                        maxLines: 1,
                        controller: addressController,
                      ),

                      // email
                      textFeld(
                        hintText: "email",
                        icon: Icons.email,
                        inputType: TextInputType.emailAddress,
                        maxLines: 1,
                        controller: emailController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: currentStep >= 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text('Vehicule'),
          content: Container(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    selectImageVehicule();
                  },
                  child: imagevehicule == null
                      ? CircleAvatar(
                          child: Image.asset(
                          'images/car2.png',
                          width: 60,
                          height: 60,
                        )
                          //backgroundColor: Colors.,
                          )
                      : CircleAvatar(
                          backgroundImage: FileImage(imagevehicule!),
                          radius: 60,
                        ),
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
                        hintText: "chevrolet",
                        icon: Icons.account_circle,
                        inputType: TextInputType.text,
                        maxLines: 1,
                        controller: nomvehiculeController,
                      ),
                      // email
                      textFeld(
                        hintText: "type",
                        icon: Icons.car_crash,
                        inputType: TextInputType.text,
                        maxLines: 1,
                        controller: typeController,
                      ),
                      textFeld(
                        hintText: "immatriculation",
                        icon: Icons.numbers,
                        inputType: TextInputType.text,
                        maxLines: 1,
                        controller: immatriculationController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: currentStep >= 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: Text('Pieces'),
          content: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /* ButtonWidget(
              text: 'Select File',
              icon: Icons.attach_file,
              onClicked: selectFile,
            ), */
                Container(
                  child: Column(
                    children: [
                      Text('Permis'),
                      InkWell(
                        onTap: selectImageP,
                        child: permisconduire == null
                            ? Container(
                                child: Image.asset(
                                  'images/file.png',
                                  width: 80,
                                  height: 80,
                                ),
                                //backgroundColor: Colors.,
                              )
                            : Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(permisconduire!))),
                              ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text('CG'),
                      InkWell(
                        onTap: selectImagecg,
                        child: cartegrise == null
                            ? Container(
                                child: Image.asset(
                                  'images/file.png',
                                  width: 80,
                                  height: 80,
                                ),
                                //backgroundColor: Colors.,
                              )
                            : Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(cartegrise!))),
                              ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text('CT'),
                      InkWell(
                        onTap: selectImagect,
                        child: controletechnique == null
                            ? Container(
                                child: Image.asset(
                                  'images/file.png',
                                  width: 80,
                                  height: 80,
                                ),
                                //backgroundColor: Colors.,
                              )
                            : Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(controletechnique!))),
                              ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Step(
          state: currentStep >= 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: Text('Complete'),
          content: Container(
            // color: Color.fromRGBO(40, 0, 81, 0.04),
            width: 300,
            height: 100,
            child: Card(
                // margin: EdgeInsets.all(5),
                color: Colors.white10,
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Address: '),
                          Text('Email: '),
                          Text('Nom:'),
                          Text('Type:'),
                          Text('Immatriculation:'),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(' ${addressController.text.toString()}'),
                          Text(' ${emailController.text.toString()}'),
                          Text(' ${nomvehiculeController.text.toString()}'),
                          Text(' ${typeController.text.toString()}'),
                          Text(' ${immatriculationController.text.toString()}'),
                        ],
                      ),
                    ),
                    /* Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround ,
                  children: [
                    Text('Address: '),
                    Text(' ${addressController.text.toString()}'),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround ,
                  children: [
                    Text('Email: '),
                    Text(' ${emailController.text.toString()}'),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround ,
                  children: [
                    Text('Nom:'),
                    Text('Nom: ${nomvehiculeController.text.toString()}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround ,
                  children: [
                    Text('Type:'),
                    Text('${typeController.text.toString()}'),
                  ],
                ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround ,
                  children: [
                    Text('Immatriculation:'),
                    Text('${immatriculationController.text.toString()}'),
                  ],
                ), */
                    /*  Padding(padding: EdgeInsets.all(5)),
                Text('Address: ${addressController.text.toString()}'),
                Text('Email: ${emailController.text.toString()}'),
                Text('Nom: ${nomvehiculeController.text.toString()}'),
                Text('Type: ${typeController.text.toString()}'),
                Text('Type: ${immatriculationController.text.toString()}'), */
                  ],
                )),
          ),
        ),
      ];

  /* validation */
  bool validateCurrentStep() {
    switch (currentStep) {
      case 0:
        return validateStep0();
      case 1:
        return validateStep1();
      /*   case 2:
        return validateStep2(); */
      // Add more cases for other steps if needed
      default:
        return true; // Return true by default
    }
  }

  bool validateStep0() {
    if (firstnameController.text.isNotEmpty &&
        lastnameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      return true;
    } else {
      showSnackBar(context, "Veillez remplir tous les champs!");
      return false;
    }
  }

  bool validateStep1() {
    if (nomvehiculeController.text.isNotEmpty &&
        typeController.text.isNotEmpty &&
        immatriculationController
            .text.isNotEmpty /* && imagevehicule != null */) {
      return true;
    } else {
      showSnackBar(context, "Veillez remplir tous les champs!");
      return false;
    }
  }

  /* bool validateStep2() {
    return // Add validation conditions for Step 2 fields
        true; // Return true if all fields are valid
  } */

  // stocker les informations dans la cage convoyeurs
  //stocker les fichiers
  @override
  Widget build(BuildContext context) {
    // final fileName = permisconduire != null ? basename(permisconduire!.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Image.asset('images/previous.png', height: 10, width: 10),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromRGBO(225, 225, 225, 1))),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Spacer(),
            Text(
              'Livreur',
              textAlign: TextAlign.end,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400, fontSize: 12, color: myColor1),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Theme(
          data: ThemeData(
            primarySwatch:
                Colors.deepPurple, // Change this to the color you want
            //accentColor: Colors.blueAccent, // Change this to the color you want
            textTheme: TextTheme(
              bodyText2: TextStyle(
                  color: Colors.black), // Change this to the color you want
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Stepper(
                  type: StepperType.vertical,
                  steps: getSteps(),
                  currentStep: currentStep,
                  /* onStepContinue: () {
                          final isLastStep =
                              currentStep == getSteps().length - 1;
                          if (isLastStep) {
                            setState(() {
                              isCompleted = true; // Use the assignment operator '=' instead of '=='
                              print('iscompleted');
                            });
                          } else {
                            setState(() => currentStep += 1);
                          }
                        }, */
                  onStepContinue: () {
                    bool isValid = validateCurrentStep();
                    if (isValid) {
                      final isLastStep = currentStep == getSteps().length - 1;
                      if (isLastStep) {
                        setState(() {
                          isCompleted = true;
                          print('iscompleted');
                          //send date to the server
                          //storeData();
                          checkNetworkAvaibility();
                        });
                      } else {
                        setState(() => currentStep += 1);
                      }
                    } else {
                      // Show an error message or handle the case where fields are not valid
                    }
                  },
                  onStepCancel: () {
                    if (currentStep > 0) {
                      setState(() => currentStep -= 1);
                    }
                  },
                  onStepTapped: (step) => setState(() {
                    currentStep = step;
                  }),
                  controlsBuilder:
                      (BuildContext context, ControlsDetails controlsDetails) {
                    final isLastStep = currentStep == getSteps().length - 1;
                    return Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: controlsDetails
                                  .onStepContinue, // Corrected line

                              child: Text(isLastStep ? 'Confirm' : 'Next'),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          if (currentStep != 0)
                            Expanded(
                              child: ElevatedButton(
                                onPressed: controlsDetails
                                    .onStepCancel, // Corrected line
                                child: Text('Previous'), // Corrected text
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  StatelessWidget buildIncompleted() {
    return Container(
      color: Colors.white,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('images/unsuccess.png', width: 200, height: 200),
          ),
          Card(
            // color: Colors.blue,
            margin: EdgeInsets.all(20),
            child: Text(
              'Nous avons une erreur !',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400, fontSize: 12),
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(
                      color: Colors.red,
                      //color: Color.fromRGBO(40, 0, 81, 1),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Homescreencustomer()));
              },
              child: Text('dieuredieuf'))
          //clear textfiel
        ],
      ),
    );
  }

  StatelessWidget buildCompleted() {
    return Container(
      color: Colors.white,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('images/success.png', width: 200, height: 200),
          ),
          Card(
            // color: Colors.blue,
            margin: EdgeInsets.all(20),
            child: Text(
              'Inscription bien reussi ! nous allons vous revenir pour les derniers modalites',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400, fontSize: 12),
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(
                      color: Color.fromRGBO(40, 0, 81, 1),
                      //color: Color.fromRGBO(40, 0, 81, 1),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Homescreendriver()));
              },
              child: Text('dieuredieuf'))
          //clear textfiel
        ],
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => permisconduire = File(path));
  }

  // store data data to database
  void storeData() async {
    final ap = Provider.of<MyAuthProvider>(context, listen: false);
    var status = 0;
    LivreurModel driverModel = LivreurModel(
        //bio: bioController.text.trim(),
        profilePic: "",
        /* profileVoiture: "",
      profilePermis: "",
      profileCG: "",
      profileCT: "", */
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        phoneNumber: ap.userModel.phoneNumber,
        uid: ap.userModel.uid,
        firstname: firstnameController.text.trim(),
        lastname: lastnameController.text.trim(),
        email: emailController.text,
        address: addressController.text,
        profilePermis: '',
        status: 0);
    CarModel carModel = CarModel(
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        uid: ap.userModel.uid,
        profileVoiture: "",
        profileCT: "",
        profileCG: "");
    if (imageConducteur != null) {
      ap.saveDriverDataToFirebase(
        context: context,
        livreurModel: driverModel,
        profilePic: imageConducteur!,
        onFailure: () {
          buildIncompleted();
        },
        onSuccess: () {
          buildCompleted();
          /*  Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const buildC(),
              ),
              (route) => false); */

          /*  ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false),
                    ),
              ); */
        },
        permis: permisconduire!,
        carModel: carModel,
        profileVoiture: imagevehicule!,
        CG: cartegrise!,
        CT: controletechnique!,
        //CG: cartegrise!, CT: context!,
        // profileVoiture: imagevehicule!,
      );
    } else {
      showSnackBar(context, "Please upload your profile photo");
    }
  }
  /* Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  } */

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
        cursorColor: Colors.purple,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromRGBO(40, 0, 81, 0.5),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
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
          fillColor: Colors.purple.shade50,
          filled: true,
        ),
      ),
    );
  }
}
