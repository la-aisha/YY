class UserModel {
  String firstname;
  String lastname;
  
  
  String createdAt;
  String phoneNumber;
  String uid;

  UserModel({
    required this.firstname,
    required this.lastname,
    required this.createdAt,
    required this.phoneNumber,
    required this.uid,
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "firstname": firstname,
      "lastname": lastname,
      "uid": uid,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
    };
  }
}
