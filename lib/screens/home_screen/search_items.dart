import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Widgets/counter.dart';
import 'package:food_app/colorsconfig/colorss.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchItems extends StatefulWidget {
  bool isbool;
  String prodName;
  String prodUnit;
  String prodImage;
  int prodPrice;
  int prodQuantity;
  String prodId;
  Function onDelete;
  SearchItems(
      {this.onDelete,
      this.prodQuantity,
      this.prodName,
      this.prodImage,
      this.prodPrice,
      this.isbool,
      this.prodUnit,
      this.prodId});

  @override
  _SearchItemsState createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  int count;
  ReviewCartProvider reviewCartProvider;
  getCount() {
    setState(() {
      count = widget.prodQuantity;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCount();
  }

  @override
  Widget build(BuildContext context) {
    // getCount();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 100,
            child: Image.network(widget.prodImage),
          )),
          Expanded(
              child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: widget.isbool == false
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      widget.prodName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: textColor),
                    ),
                    Text(
                      '${widget.prodPrice}\$/50 gram',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30)),
                  child: widget.isbool == false
                      ? Row(
                          children: [
                            Text(
                              '50 gram',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 14),
                            ),
                            Center(
                              child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    size: 20,
                                    color: primaryColor,
                                  ),
                                  onPressed: () {}),
                            )
                          ],
                        )
                      : Text(
                          widget.prodUnit,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 14),
                        ),
                ),
              ],
            ),
          )),
          Expanded(
              child: Container(
            height: 100,
            padding: widget.isbool == false
                ? EdgeInsets.symmetric(horizontal: 15, vertical: 32)
                : EdgeInsets.only(left: 15, right: 15, top: 20),
            child: widget.isbool == false
                ? Container(
                    height: 25,
                    width: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 20,
                          color: primaryColor,
                        ),
                        Text(
                          'ADD',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 14),
                        )
                      ],
                    ),
                  )
                : Column(
                    children: [
                      InkWell(
                        child: Icon(Icons.delete_forever),
                        onTap: widget.onDelete,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 25,
                        width: 70,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(30)),
                        // child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Icon(
                        //       Icons.add,
                        //       size: 20,
                        //       color: primaryColor,
                        //     ),
                        //     Text(
                        //       "$prodQuantity",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.grey,
                        //           fontSize: 14),
                        //
                        //     ),
                        //     Icon(
                        //       Icons.remove,
                        //       size: 20,
                        //       color: primaryColor,
                        //     ),
                        //   ],
                        // ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 3),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.white,
                              ),
                              child: Text(
                                "$count",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 15,
                                    backgroundColor: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          )),
        ],
      ),
    );
  }
}
