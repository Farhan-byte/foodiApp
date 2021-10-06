import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/colorsconfig/colorss.dart';
import 'package:food_app/modals/wishlist_model.dart';
import 'package:food_app/providers/wishlist_provider.dart';
import 'package:food_app/screens/home_screen/search_items.dart';
import 'package:provider/provider.dart';

class wishListScreen extends StatefulWidget {
  @override
  _wishListScreenState createState() => _wishListScreenState();
}

class _wishListScreenState extends State<wishListScreen> {
  WishListProvider wishListProvider;

  showAlertDialog(BuildContext context, WishlistModal delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        wishListProvider.deleteWishListData(delete.WishlistId);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Sure Want to Delete"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    wishListProvider.fetchWishlistData();
    // print(wishListProvider.getWishlistCartList.length);
    return Scaffold(
      appBar: AppBar(
        title: Text('Wish List'),
        backgroundColor: primaryColor,
      ),

      body: wishListProvider.getWishlistCartList.isEmpty
          ? Center(
              child: Text('No Data'),
            )
          : ListView.builder(
              itemCount: wishListProvider.getWishlistCartList.length,
              itemBuilder: (context, index) {
                WishlistModal data =
                    wishListProvider.getWishlistCartList[index];
                return Column(
                  children: [
                    Padding(
                      child: SearchItems(
                        isbool: true,
                        prodQuantity: data.WishlistQuantity,
                        prodPrice: data.WishlistPrice,
                        prodImage: data.WishlistImage,
                        prodName: data.WishlistName,
                        onDelete: () {
                          showAlertDialog(context, data);
                        },
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    Divider(
                      height: 2,
                      thickness: 2,
                    ),
                  ],
                );
              }),
      // body: (ListView(
      //   children: [
      //     SizedBox(
      //       height: 15,
      //     ),
      //     Padding(
      //       child: SearchItems(
      //         isbool: true,
      //       ),
      //       padding: EdgeInsets.symmetric(vertical: 5),
      //     ),
      //     Divider(
      //       height: 2,
      //       thickness: 2,
      //     ),
      //     Padding(
      //       child: SearchItems(isbool: true),
      //       padding: EdgeInsets.symmetric(vertical: 5),
      //     ),
      //     Divider(
      //       height: 2,
      //       thickness: 2,
      //     ),
      //     Padding(
      //       child: SearchItems(isbool: true),
      //       padding: EdgeInsets.symmetric(vertical: 5),
      //     ),
      //     Divider(
      //       height: 2,
      //       thickness: 2,
      //     ),
      //     Padding(
      //       child: SearchItems(isbool: true),
      //       padding: EdgeInsets.symmetric(vertical: 5),
      //     ),
      //   ],
      // )),
    );
  }
}
