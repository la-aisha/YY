class CarModel {
  
  String profileVoiture;
  String profileCT;
  String profileCG;

  String createdAt;
  String uid;

  CarModel({
    required this.createdAt,
    required this.uid,
    required this.profileVoiture,
    required this.profileCT,
    required this.profileCG,

  });

  // from map
  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
     
      uid: map['uid'] ?? '',
      createdAt: map['createdAt'] ?? '',
      profileCG: map['profileCG'] ?? '',
      profileCT: map['profileCT'] ?? '',
       profileVoiture: '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
     
      "uid": uid,
      "createdAt": createdAt,
      "profileVoiture": profileVoiture,
      "profileCG": profileCG,
      "profileCT": profileCT,

    };
  }
}
