import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yy/model/car_model.dart';
import 'package:yy/model/convoyeur_model.dart';
import 'package:yy/screen/Otp.dart';
import 'package:yy/screen/OtpDriver.dart';
import 'package:yy/screen/RegisterCostumer.dart';
import 'package:yy/screen/ScreenCustomer/HomeScreenCustomer.dart';
import 'package:yy/utils/utils.dart';

import '../model/user_model.dart';

class MyAuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _isloading = false;
  bool get isLoading => _isloading;

  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  LivreurModel? _livreurModel;
  get livreurModel => _livreurModel!;

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

   //store date
  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }


  void checksignin() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("issignedin") ?? false;
    notifyListeners();
  }

  MyAuthProvider() {
    checksignin();
  }

  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  Future getDataFromFirestoreDriver() async {
    await _firebaseFirestore
        .collection("drivers")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _livreurModel = LivreurModel(
        firstname: snapshot['firstname'],
        lastname: snapshot['lastname'],
        createdAt: snapshot['createdAt'],
        uid: snapshot['uid'],
        phoneNumber: snapshot['phoneNumber'],
        email: snapshot['email'],
        address: snapshot['address'],
        profilePermis: snapshot['profilePermis'],
        profilePic: snapshot['profilePic'],
        status: snapshot['status'],
      );
      _uid = userModel.uid;
    });
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
  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  void signInWithPhoneDriver(
      BuildContext context, String phonenumber, UserModel? user) async {
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
                builder: (context) => OtpDriver(
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

  void signInWithPhone(
      BuildContext context, String phonenumber, UserModel? user) async {
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

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    Function? onSuccess,
  }) async {
    _isloading = true;
    notifyListeners();
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;
      if (user != null) {
        _uid = user.uid;
        onSuccess!();
        //onSuccessDriver!();
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
      print("user user");
      return true;
    } else {
      print("new USER");
      return false;
    }
  }

  // DATABASE OPERTAIONS
  Future<bool> checkExistingDriver() async {
    DocumentSnapshot snapshotdriver =
        await _firebaseFirestore.collection("drivers").doc(_uid).get();
    if (snapshotdriver.exists) {
      print("driver exist");
      return true;
    } else {
      print("new driver");
      return false;
    }
  }

  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    // required File profilePic,
    required Function onSuccess,
    Function? onFailure,
  }) async {
    _isloading = true;
    notifyListeners();
    try {
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
      if (onFailure != null) {
        onFailure();
      }
    }
  }


//save customer
void saveDriverDataToFirebase({
  required BuildContext context,
  required LivreurModel livreurModel,
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
    String profilePicUrl = await storeFileToStorage("profilePic/$_uid", profilePic);

    // Set properties for livreurModel
    livreurModel.profilePic = profilePicUrl;
    livreurModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
    livreurModel.uid = _firebaseAuth.currentUser!.uid;

    // uploading image to firebase storage.
    String profileVoitureUrl = await storeFileToStorage("profileVoiture/$_uid", profileVoiture);

    // Set properties for livreurModel
    carModel.profileVoiture = profileVoitureUrl;

    // uploading image to firebase storage.
    String permisUrl = await storeFileToStorage("permis/$_uid", permis);

    // Set properties for livreurModel
    livreurModel.profilePermis = permisUrl;

    // uploading image to firebase storage.
    String CTUrl = await storeFileToStorage("ct/$_uid", CT);

    // Set properties for carModel
    carModel.profileCT = CTUrl;
    carModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
    carModel.uid = _firebaseAuth.currentUser!.uid;

    // uploading image to firebase storage.
    String CGUrl = await storeFileToStorage("cg/$_uid", CG);

    // Set properties for carModel
    carModel.profileCG = CGUrl;

    // Set properties for carModel
    carModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
    carModel.uid = _firebaseAuth.currentUser!.uid;

    // uploading to database
    await _firebaseFirestore
        .collection("drivers")
        .doc(_uid)
        .set(livreurModel.toMap());

    // uploading to database
    await _firebaseFirestore
      .collection("cars")
      .doc(_uid)
      .set(carModel.toMap());
    onSuccess();
  } catch (e) {
    showSnackBar(context, e.toString());
      onFailure!();
    if (onFailure != null) {
      onFailure();
    }
  } finally {
    _isloading = false;
    notifyListeners();
  }
}
 /*  //save customer
  void saveDriverDataToFirebase({
    required BuildContext context,
    required LivreurModel livreurModel,
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
        livreurModel.profilePic = value;
        livreurModel.createdAt =
            DateTime.now().millisecondsSinceEpoch.toString();
        livreurModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        livreurModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      });
      // uploading image to firebase storage.
      await storeFileToStorage("profileVoiture/$_uid", profileVoiture)
          .then((value) {
        livreurModel.profilePic = value;
        livreurModel.createdAt =
            DateTime.now().millisecondsSinceEpoch.toString();
        livreurModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        livreurModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      });
      await storeFileToStorage("permis/$_uid", permis).then((value) {
        livreurModel.profilePermis = value;
        livreurModel.createdAt =
            DateTime.now().millisecondsSinceEpoch.toString();
        livreurModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        livreurModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
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
      _livreurModel = livreurModel;
      _carModel = carModel;

      // uploading to database
      await _firebaseFirestore
          .collection("drivers")
          .doc(_uid)
          .set(livreurModel.toMap())
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

  */
  // STORING DATA LOCALLY
 
}
