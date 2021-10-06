import 'package:flutter/material.dart';

class ProductUnit extends StatelessWidget {
  Function onTap;
  String title;
  ProductUnit({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 30,
          width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(color: Colors.grey),
            color: Color(0xffd9dad9),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xffd0b84c),
                  ),
                ),
              ),
              Center(
                child: Icon(
                  Icons.arrow_drop_down,
                  size: 20,
                  color: Colors.yellow,
                ),
              )
            ],
          )),
    );
  }
}
