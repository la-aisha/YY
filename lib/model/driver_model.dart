class DriverModel {
  String firstname;
  String lastname;
  String email;
  String address;
  String profilePermis;

  String profilePic;
  /*
   String profileVoiture;
  String profileCT;
  String profileCG; */

  String createdAt;
  String phoneNumber;
  String uid;

  DriverModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.address,
    required this.profilePermis,


    required this.createdAt,
    required this.phoneNumber,
    required this.profilePic,
    required this.uid,
    /* required this.profileVoiture,
    
    required this.profileCT,
    required this.profileCG, */

  });

  // from map
  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
      profilePic: map['profilePic'] ?? '',
       profilePermis: map['profilePermis'] ?? '',
    /*   profileVoiture: map['profileVoiture'] ?? '',
     
      profileCG: map['profileCG'] ?? '',
      profileCT: map['profileCT'] ?? '', */
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "address": address,
      "uid": uid,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "profilePic": profilePic,
      "profilePermis": profilePermis,

     /*  "profileVoiture": profileVoiture,
      "profileCG": profileCG,
      "profileCT": profileCT,
 */
    };
  }
}
