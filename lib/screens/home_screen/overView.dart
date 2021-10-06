import 'package:food_app/Widgets/counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/colorsconfig/colorss.dart';
import 'package:food_app/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum SinginCharacter { fill, outline }

class ProductOverview extends StatefulWidget {
  String productName;
  String productImage;
  String productId;
  int productPrice;
  int prodQunatity;
  ProductOverview(
      {this.prodQunatity,
      this.productId,
      this.productImage,
      this.productName,
      this.productPrice});

  @override
  _ProductOverviewState createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  WishListProvider wishListProvider;
  bool wishListbool = false;
  SinginCharacter _character = SinginCharacter.fill;

  Widget bonntonNavigatorBar({
    Color iconColor,
    Color backgroundColor,
    Color color,
    String title,
    IconData iconData,
    Function ontap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          padding: EdgeInsets.all(20),
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 17,
                color: iconColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: TextStyle(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getWishListBool() async {
    await FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("YourWishList")
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (this.mounted)
                {
                  if (value.exists)
                    {
                      setState(() {
                        wishListbool = value.get("isAdd");
                      })
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    getWishListBool();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Row(
          children: [
            bonntonNavigatorBar(
              ontap: () {
                setState(() {
                  wishListbool = !wishListbool;
                });

                if (wishListbool == true) {
                  wishListProvider.addWishlistData(
                      WishlistQuantity: widget.prodQunatity,
                      WishlistName: widget.productName,
                      WishlistImage: widget.productImage,
                      WishlistId: widget.productId,
                      WishlistPrice: widget.productPrice);
                } else if (wishListbool == false) {
                  wishListProvider.deleteWishListData(widget.productId);
                }
              },
              backgroundColor: textColor,
              color: Colors.white70,
              iconColor: Colors.grey,
              title: "Add To WishList",
              iconData: wishListbool == false
                  ? Icons.favorite_outline
                  : Icons.favorite,
            ),
            bonntonNavigatorBar(
              backgroundColor: primaryColor,
              color: textColor,
              iconColor: Colors.white70,
              title: "Go To Cart",
              iconData: Icons.shop_outlined,
            ),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Color(0xffd6b738),
          iconTheme: IconThemeData(color: textColor),
          title: Text(
            "Product Overview",
            style: TextStyle(color: textColor),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    // ListTile(
                      
                    //   title: Text(widget.productName),
                    //   subtitle: Text("\$ ${widget.productPrice}"),
                    // ),
                    Container(
                        height: 250,
                        padding: EdgeInsets.all(40),
                        child: Image.network(widget.productImage)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: Text(
                        "Available Options",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 3,
                                backgroundColor: Colors.green[700],
                              ),
                              Radio(
                                value: SinginCharacter.fill,
                                groupValue: _character,
                                activeColor: Colors.green[700],
                                onChanged: (value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Text("\$ ${widget.productPrice}"),
                          SizedBox(
                            width: 180,
                          ),
                          Counter(
                            prodName: widget.productName,
                            prodImage: widget.productImage,
                            prodPrice: widget.productPrice,
                            prodId: widget.productId,
                            prodQuantity: widget.prodQunatity,
                          )
                        
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex :1,
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                child: ListView(
                  children: [
                    Text(
                      "About This Product",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "of a customer. Wikipedi In marketing, a product is an object or system made available for consumer use; it is anything that can be offered to a market to satisfy the desire or need of a customer. Wikipedi",
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
