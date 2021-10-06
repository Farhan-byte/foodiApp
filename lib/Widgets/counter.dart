import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:provider/provider.dart';

class Counter extends StatefulWidget {
  final String prodId;
  final String prodImage;
  final String prodName;
  final int prodQuantity;
  final int prodPrice;
  final String prodUnit;

  Counter(
      {this.prodId,
      this.prodImage,
      this.prodName,
      this.prodPrice,
      this.prodQuantity,
      this.prodUnit});
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  ReviewCartProvider reviewCartProvider;

  bool cntBool = false;
  int count = 1;
  getAddandQunatity() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourReviewCart")
        .doc(widget.prodId)
        .get()
        .then((value) => {
              if (this.mounted)
                {
                  if (value.exists)
                    {
                      setState(() {
                        cntBool = value.get("isAdd");
                        count = value.get("cartQuantity");
                      })
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    print(widget.prodId);
    return Expanded(
      child: cntBool == true
          ? Container(
              height: 30,
              width: 20,
              padding: EdgeInsets.only(left: 13),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                color: Color(0xffd9dad9),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          if (count == 1) {
                            setState(() {
                              cntBool = false;
                            });
                            reviewCartProvider
                                .deleteReviewCartData(widget.prodId);
                          } else if (count > 1) {
                            setState(() {
                              count--;
                              reviewCartProvider.updateReviewCartData(
                                  cartId: widget.prodId,
                                  cartImage: widget.prodImage,
                                  cartUnit: widget.prodUnit,
                                  cartName: widget.prodName,
                                  cartPrice: widget.prodPrice,
                                  cartQuantity: count);
                            });
                          }
                          ;
                        },
                        child: Icon(
                          Icons.remove,
                          color: Color(0xffd0b84c),
                          size: 16,
                        )),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Color(0xffd9dad9),
                      ),
                      child: Text(
                        '$count',
                        style:
                            TextStyle(color: Color(0xffd0b84c), fontSize: 15),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            count++;
                            reviewCartProvider.updateReviewCartData(
                                cartId: widget.prodId,
                                cartImage: widget.prodImage,
                                cartName: widget.prodName,
                                cartUnit: widget.prodUnit,
                                cartPrice: widget.prodPrice,
                                cartQuantity: count);
                          });
                        },
                        child: Icon(
                          Icons.add,
                          color: Color(0xffd0b84c),
                          size: 16,
                        )),
                  ],
                ),
              ),
            )
          : Container(
              height: 30,
              width: 10,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                color: Color(0xffd9dad9),
              ),
              child: Center(
                child: InkWell(
                  child: Text(
                    "ADD",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xffd0b84c),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      cntBool = true;
                    });
                    reviewCartProvider.addReviewCartData(
                      cartId: widget.prodId,
                      cartUnit: widget.prodUnit,
                      cartImage: widget.prodImage,
                      cartName: widget.prodName,
                      cartPrice: widget.prodPrice,
                      cartQuantity: count,
                    );
                  },
                ),
              ),
            ),
    );
  }
}
