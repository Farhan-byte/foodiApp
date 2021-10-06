import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/modals/review_cart_modal.dart';
import 'package:food_app/modals/wishlist_model.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ReviewCartProvider with ChangeNotifier {
  ReviewCartModal reviewCartModal;
  List<ReviewCartModal> ReviewCartList = [];
  void addReviewCartData({
    String cartUnit,
    String cartId,
    String cartImage,
    String cartName,
    int cartQuantity,
    int cartPrice,
  }) async {
    await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .set({
      "cartId": cartId,
      "cartImage": cartImage,
      "cartUnit": cartUnit,
      "cartName": cartName,
      "cartQuantity": cartQuantity,
      "cartPrice": cartPrice,
      "isAdd": true
    });
  }

  void updateReviewCartData({
    String cartUnit,
    String cartId,
    String cartImage,
    String cartName,
    int cartQuantity,
    int cartPrice,
  }) async {
    await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .update({
      "cartId": cartId,
      "cartImage": cartImage,
      "cartName": cartName,
      "cartQuantity": cartQuantity,
      "cartPrice": cartPrice,
      "cartUnit": cartUnit,
      "isAdd": true,
    });
  }

  fetchReviewCartData() async {
    List<ReviewCartModal> newList = [];

    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourReviewCart")
        .get();
    value.docs.forEach((element) {
      reviewCartModal = ReviewCartModal(
          cartName: element.get("cartName"),
          cartUnit: element.get("cartUnit"),
          cartId: element.get("cartId"),
          cartQuantity: element.get("cartQuantity"),
          cartPrice: element.get("cartPrice"),
          cartImage: element.get("cartImage"));
      newList.add(reviewCartModal);
    });
    ReviewCartList = newList;
    notifyListeners();
  }

  List<ReviewCartModal> get getReviewCartList {
    return ReviewCartList;
  }

  getTotalPrice() {
    double total = 0.0;

    getReviewCartList.forEach((element) {
      total += element.cartPrice * element.cartQuantity;
    });
    return total;
  }

  deleteReviewCartData(String cartId) async {
    await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .delete()
        .then((_) => print('Deleted'))
        .catchError((error) => print('Delete failed: $error'));
    notifyListeners();
  }
}
