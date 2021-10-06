import 'package:flutter/material.dart';

class OrderItem extends StatefulWidget {
  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
          "https://www.pngplay.com/wp-content/uploads/6/Apple-Fruit-Half-Transparent-PNG.png"),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Food Name",
            style: TextStyle(color: Colors.grey[600]),
          ),
          Text(
            "50 Gram",
            style: TextStyle(color: Colors.grey[600]),
          ),
          Text(
            "40 \$",
            style: TextStyle(color: Colors.grey[600]),
          )
        ],
      ),
    );
  }
}
