import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_app/colorsconfig/colorss.dart';

class SingleDeliveryItem extends StatelessWidget {
  String address;
  String addressType;
  String phnNo;
  String title;
  SingleDeliveryItem({this.title, this.address, this.addressType, this.phnNo});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Container(
                height: 25,
                width: 60,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    addressType,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          leading: CircleAvatar(
            backgroundColor: primaryColor,
            radius: 8,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address),
              SizedBox(
                height: 5,
              ),
              Text(phnNo)
            ],
          ),
        ),
        Divider(
          height: 35,
        )
      ],
    );
  }
}
