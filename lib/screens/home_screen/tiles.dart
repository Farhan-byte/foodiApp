import 'package:flutter/material.dart';

class tilesSide extends StatelessWidget {
  final IconData icon;
  final String title;
  Function ontap;
  tilesSide({this.icon, this.title, this.ontap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      leading: Icon(
        icon,
        size: 32,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black45),
      ),
    );
  }
}
