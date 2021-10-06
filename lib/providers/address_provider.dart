import 'package:flutter/material.dart';
import 'package:food_app/modals/address_model.dart';

class AddressProvider with ChangeNotifier {
  String address = "Add Data";
  String addressType = "Add Data";
  String phnNo = "Add Data";
  String title = "Add Data";

  setAddress(String val) {
    address = val;
    notifyListeners();
  }

  setAddressType(String val) {
    addressType = val;
    notifyListeners();
  }

  setTitle(String val) {
    title = val;
    notifyListeners();
  }

  setPhn(String val) {
    phnNo = val;
    notifyListeners();
  }
}
