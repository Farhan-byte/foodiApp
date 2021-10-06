import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_app/colorsconfig/colorss.dart';
import 'package:food_app/modals/address_model.dart';
import 'package:food_app/providers/address_provider.dart';
import 'package:food_app/screens/home_screen/DeliveryDetails/single_delivery_item.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  AddressProvider addressProvider;
  @override
  Widget build(BuildContext context) {
    addressProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Details"),
        backgroundColor: primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
      bottomNavigationBar: Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: Text("Add New Address"),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ListView(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: TextField(
                          onChanged: (val) {
                            addressProvider.setTitle(val);
                          },
                          style: TextStyle(color: Colors.black87, fontSize: 15),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                            fillColor: Color(0xffc2c2c2),
                            filled: true,
                            hintText: "add Name",
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: TextField(
                          onChanged: (val) {
                            addressProvider.setAddressType(val);
                          },
                          style: TextStyle(color: Colors.black87, fontSize: 15),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                            fillColor: Color(0xffc2c2c2),
                            filled: true,
                            hintText: 'add addresstype',
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: TextField(
                          onChanged: (val) {
                            addressProvider.setAddress(val);
                          },
                          style: TextStyle(color: Colors.black87, fontSize: 15),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                            fillColor: Color(0xffc2c2c2),
                            filled: true,
                            hintText: "add address",
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: TextField(
                          onChanged: (val) {
                            addressProvider.setPhn(val);
                          },
                          style: TextStyle(color: Colors.black87, fontSize: 15),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                            fillColor: Color(0xffc2c2c2),
                            filled: true,
                            hintText: "add Ph no.",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: primaryColor),
                        height: 50,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 90),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                              child: Text(
                            "Done",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      )
                    ],
                  );
                });
          },
          color: primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Location"),
            leading: Icon(
              Icons.location_on_outlined,
              size: 25,
            ),
          ),
          Divider(
            height: 2,
          ),
          Column(
            children: [
              SingleDeliveryItem(
                address: addressProvider.address,
                addressType: addressProvider.addressType,
                title: addressProvider.title,
                phnNo: addressProvider.phnNo,
              )
            ],
          )
        ],
      ),
    );
  }
}
