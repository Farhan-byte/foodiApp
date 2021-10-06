import 'package:flutter/material.dart';
import 'package:food_app/providers/User_provider.dart';
import 'package:food_app/screens/home_screen/MyProfile.dart';
import 'package:food_app/screens/home_screen/Review_cart.dart';
import 'package:food_app/screens/home_screen/tiles.dart';
import 'package:food_app/screens/home_screen/wishlist_screen.dart';

class DrawerSide extends StatefulWidget {
  UserProvider userProvider;
  DrawerSide({this.userProvider});
  @override
  _DrawerSideState createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  @override
  Widget build(BuildContext context) {
    // widget.userProvider.getUserData();
    var userData = widget.userProvider.fetchUserData;
    return Drawer(
      child: Container(
        color: Color(0xffd6b738),
        child: ListView(
          children: [
            DrawerHeader(
                child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white54,
                  radius: 44,
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    backgroundImage: NetworkImage(userData.userImage != null
                        ? userData.userImage
                        : "https://s3.envato.com/files/328957910/vegi_thumb.png"),
                    radius: 40,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userData.userName != null ? userData.userName : "Guest",
                      style: TextStyle(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 25,
                      child: OutlineButton(
                        onPressed: () {},
                        child: Text('Login'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                            side: BorderSide(width: 2)),
                      ),
                    )
                  ],
                ),
              ],
            )),
            tilesSide(icon: Icons.home_outlined, title: 'Home'),
            tilesSide(
              icon: Icons.shopping_cart,
              title: 'My Cart',
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReviewCart()));
              },
            ),
            tilesSide(
              icon: Icons.person_outlined,
              title: 'My Profile',
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyProfile(
                              userProvider: widget.userProvider,
                            )));
              },
            ),
            tilesSide(
                icon: Icons.notifications_active_outlined,
                title: 'Notifications'),
            tilesSide(
                icon: Icons.star_border_outlined, title: 'Ratings & Reviews'),
            tilesSide(
              icon: Icons.favorite_outline,
              title: 'Wish List',
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => wishListScreen()));
              },
            ),
            tilesSide(icon: Icons.copy_outlined, title: 'Raise a Complaint'),
            tilesSide(icon: Icons.format_quote_outlined, title: 'FAQs'),
            Container(
              height: 350,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Support'),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text('Call Us :'),
                      Text('+545447478947'),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text('Mail Us :'),
                      Text('euhf@gmail.com'),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
