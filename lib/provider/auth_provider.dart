import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yy/model/car_model.dart';
import 'package:yy/model/driver_model.dart';
import 'package:yy/screen/Otp.dart';
import 'package:yy/screen/RegisterCostumer.dart';
import 'package:yy/screen/ScreenCustomer/HomeScreenCustomer.dart';
import 'package:yy/utils/utils.dart';

import '../model/user_model.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _isloading = false;
  bool get isLoading => _isloading;

  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  DriverModel? _driverModel;
  get driverModel => _driverModel!;
  
  CarModel? _carModel;
  get carModel => _carModel!;

  String? _uid;
  String get uid => _uid!;

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future googleLogin( BuildContext context,
  ) async {
    /*  final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners(); */

    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);
      notifyListeners();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Homescreencustomer()));
    } catch (error) {
      // Handle the error here
      print('Error during Google login: $error');


    }
  }

  AuthProvider() {
    checksignin();
  }

  void checksignin() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("issignedin") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  void signInWithPhone(
      BuildContext context, String phonenumber, UserModel user) async {
    try {
      _userModel = user;
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phonenumber,
          verificationCompleted: (PhoneAuthCredential phoneauthcrediential) {
            _firebaseAuth.signInWithCredential(phoneauthcrediential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Otp(
                  verificationId: verificationId,
                  user: _userModel ??
                      UserModel(
                        firstname: "",
                        lastname: "",
                        createdAt: "",
                        phoneNumber: "",
                        uid: "",
                      ),
                ),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  void verifyOtp(
      {required BuildContext context,
      required String verificationId,
      required String userOtp,
      required Function onSuccess}) async {
    _isloading = true;
    notifyListeners();
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;
      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  // DATABASE OPERTAIONS
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("clients").doc(_uid).get();
    if (snapshot.exists) {
      print("USER EXISTS");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }

  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    // required File profilePic,
    required Function onSuccess,
  }) async {
    _isloading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      /*  await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
        userModel.profilePic = value;
        userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      }); */
      _userModel = userModel;

      // uploading to database
      await _firebaseFirestore
          .collection("clients")
          .doc(_uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isloading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isloading = false;
      notifyListeners();
    }
  }

  //save customer
   void saveDriverDataToFirebase({
    required BuildContext context,
    required DriverModel driverModel,
    required CarModel carModel,
    required File profilePic,
    required File profileVoiture,
    required File permis,
    required File CG,
    required File CT,
    required Function onSuccess,
    Function? onFailure, // New parameter for handling failure

  }) async {
    _isloading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
       await storeFileToStorage("profilePic/$_uid", profilePic).then((value) {
        driverModel.profilePic = value;
        driverModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        driverModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        driverModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      }); 
       // uploading image to firebase storage.
        await storeFileToStorage("profileVoiture/$_uid", profileVoiture).then((value) {
        driverModel.profilePic = value;
        driverModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        driverModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        driverModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      });  
       await storeFileToStorage("permis/$_uid", permis).then((value) {
        driverModel.profilePermis = value;
        driverModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        driverModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        driverModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      }); 
       await storeFileToStorage("ct/$_uid", CT).then((value) {
        carModel.profileCT = value;
        carModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        //carModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        carModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      }); 
       await storeFileToStorage("cg/$_uid", CG).then((value) {
        carModel.profileCG = value;
        carModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        //carModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        carModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      });  
       await storeFileToStorage("cg/$_uid", profileVoiture).then((value) {
        carModel.profileVoiture = value;
        carModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        //carModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        carModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      });  
      _driverModel = driverModel;
      _carModel = carModel;


      // uploading to database
      await _firebaseFirestore
          .collection("drivers")
          .doc(_uid)
          .set(driverModel.toMap())
          .then((value) {
        onSuccess();
        _isloading = false;
        notifyListeners();
      });
       // uploading to database
      await _firebaseFirestore
          .collection("cars")
          .doc(_uid)
          .set(carModel.toMap())
          .then((value) {
        onSuccess();
        _isloading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isloading = false;
      notifyListeners();

      if (onFailure != null) {
      onFailure(); 
    }
    }
  }
  //store date
   Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // STORING DATA LOCALLY
  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  Future getDataFromFirestore() async {
    await _firebaseFirestore
        .collection("clients")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
        firstname: snapshot['firstname'],
        lastname: snapshot['lastname'],
        createdAt: snapshot['createdAt'],
        //bio: snapshot['bio'],
        uid: snapshot['uid'],
        // profilePic: snapshot['profilePic'],
        phoneNumber: snapshot['phoneNumber'],
      );
      _uid = userModel.uid;
    });
  }


  Future getDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
    notifyListeners();
  }


}
