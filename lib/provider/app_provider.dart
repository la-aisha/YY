import 'package:flutter/cupertino.dart';
import 'package:yy/model/address_model.dart';

class AppProvider extends ChangeNotifier {
  AddressModel? pickupLocation;
  AddressModel? dropoffLocation;
  //fonction pickup
  void updatePickupLocation(AddressModel pickupModel) {
    pickupLocation = pickupModel;
    notifyListeners();
  }
  //fonction drop
  void updateDropoffLocation(AddressModel dropoffModel) {
    dropoffLocation = dropoffModel;
    notifyListeners();
  }
}
