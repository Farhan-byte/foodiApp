import 'package:flutter/material.dart';
import 'package:food_app/colorsconfig/colorss.dart';
import 'package:food_app/modals/review_cart_modal.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/screens/home_screen/DeliveryDetails/delivery_details.dart';
import 'package:food_app/screens/home_screen/DeliveryDetails/single_delivery_item.dart';
import 'package:food_app/screens/home_screen/search_items.dart';
import 'package:provider/provider.dart';

class ReviewCart extends StatefulWidget {
  @override
  _ReviewCartState createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  ReviewCartProvider reviewCartProvider;

  showAlertDialog(BuildContext context, ReviewCartModal delete) {
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
        reviewCartProvider.deleteReviewCartData(delete.cartId);
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
    reviewCartProvider = Provider.of(context);
    reviewCartProvider.fetchReviewCartData();
    // print(reviewCartProvider.getReviewCartList.length);
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Cart'),
        backgroundColor: primaryColor,
      ),
      bottomNavigationBar: ListTile(
        title: Text('Total Amount'),
        subtitle: Text('\$ ${reviewCartProvider.getTotalPrice()}'),
        trailing: Container(
          decoration: BoxDecoration(
              color: Color(0xffd1ad17),
              borderRadius: BorderRadius.circular(30)),
          width: 160,
          child: MaterialButton(
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DeliveryDetails()));
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ),
      body: reviewCartProvider.getReviewCartList.isEmpty
          ? Center(
              child: Text('No Data'),
            )
          : ListView.builder(
              itemCount: reviewCartProvider.getReviewCartList.length,
              itemBuilder: (context, index) {
                ReviewCartModal data =
                    reviewCartProvider.getReviewCartList[index];
                return Column(
                  children: [
                    Padding(
                      child: SearchItems(
                        isbool: true,
                        prodQuantity: data.cartQuantity,
                        prodUnit: data.cartUnit,
                        prodPrice: data.cartPrice,
                        prodImage: data.cartImage,
                        prodName: data.cartName,
                        prodId: data.cartId,
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

    );
  }
}
