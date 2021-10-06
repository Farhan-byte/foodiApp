import 'package:flutter/material.dart';
import 'package:food_app/colorsconfig/colorss.dart';
import 'package:food_app/providers/address_provider.dart';
import 'package:food_app/screens/home_screen/DeliveryDetails/order_item.dart';
import 'package:provider/provider.dart';

class PaymentDetails extends StatefulWidget {
  @override
  _PaymentDetailsState createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  AddressProvider addressProvider;
  @override
  Widget build(BuildContext context) {
    addressProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Payment Details"),
      ),
      bottomNavigationBar: ListTile(
        title: Text('Total Amount'),
        subtitle: Text('170 \$'),
        trailing: Container(
          decoration: BoxDecoration(
              color: Color(0xffd1ad17),
              borderRadius: BorderRadius.circular(30)),
          width: 160,
          child: MaterialButton(
            child: Text(
              'Place Order',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(addressProvider.title),
                    subtitle: Text(addressProvider.address),
                  ),
                  Divider(
                    height: 2,
                  ),
                  ExpansionTile(
                    title: Text("Ordered Items  6"),
                    children: [
                      OrderItem(),
                      OrderItem(),
                      OrderItem(),
                      OrderItem(),
                      OrderItem(),
                      OrderItem(),
                    ],
                  ),
                  ListTile(
                    leading: Text(
                      "SubTotal",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text("200 \$"),
                    minVerticalPadding: 8,
                  ),
                  ListTile(
                      leading: Text(
                        "Discounts",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text("200 \$"),
                      minVerticalPadding: 8),
                  ListTile(
                      leading: Text(
                        "Shipping Charges",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text("200 \$"),
                      minVerticalPadding: 8)
                ],
              );
            }),
      ),
    );
  }
}
