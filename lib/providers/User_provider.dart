import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/modals/UserModal.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  void addUserData({
    User currentUser,
    String userName,
    String userEmail,
    String userImage,
  }) async {
    await FirebaseFirestore.instance
        .collection("UserData")
        .doc(currentUser.uid)
        .set({
      "userName": userName,
      "userEmail": userEmail,
      "userImage": userImage,
      "userID": currentUser.uid,
    });
  }

  UserModal currentUser;
  getUserData() async {
    UserModal userModal;
    var value = await FirebaseFirestore.instance
        .collection("UserData")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    if (value.exists) {
      userModal = UserModal(
        userName: value.get("userName"),
        userImage: value.get("userImage"),
        userUid: value.get("userID"),
        userEmail: value.get("userEmail"),
      );
      currentUser = userModal;
      notifyListeners();
    }
  }

  UserModal get fetchUserData {
    return currentUser;
  }
}
