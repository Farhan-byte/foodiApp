import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/modals/wishlist_model.dart';

class WishListProvider with ChangeNotifier {
  WishlistModal wishlistModal;
  List<WishlistModal> WishlistCartList = [];
  void addWishlistData({
    String WishlistId,
    String WishlistImage,
    String WishlistName,
    int WishlistQuantity,
    int WishlistPrice,
  }) async {
    await FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourWishList")
        .doc(WishlistId)
        .set({
      "WishlistId": WishlistId,
      "WishlistImage": WishlistImage,
      "WishlistName": WishlistName,
      "WishlistQuantity": WishlistQuantity,
      "WishlistPrice": WishlistPrice,
      "isAdd": true
    });
  }

  fetchWishlistData() async {
    List<WishlistModal> newList = [];

    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourWishList")
        .get();
    value.docs.forEach((element) {
      wishlistModal = WishlistModal(
          WishlistName: element.get("WishlistName"),
          WishlistId: element.get("WishlistId"),
          WishlistQuantity: element.get("WishlistQuantity"),
          WishlistPrice: element.get("WishlistPrice"),
          WishlistImage: element.get("WishlistImage"));
      newList.add(wishlistModal);
    });
    WishlistCartList = newList;
    notifyListeners();
  }

  List<WishlistModal> get getWishlistCartList {
    return WishlistCartList;
  }

  deleteWishListData(String cartId) async {
    await FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourWishList")
        .doc(cartId)
        .delete()
        .then((_) => print('Deleted'))
        .catchError((error) => print('Delete failed: $error'));
    notifyListeners();
  }
}
