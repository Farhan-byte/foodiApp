import 'package:flutter/material.dart';
import 'package:food_app/auth/signIn.dart';
import 'package:food_app/auth/signUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_app/providers/ProductProvider.dart';
import 'package:food_app/providers/User_provider.dart';
import 'package:food_app/providers/address_provider.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/providers/wishlist_provider.dart';
import 'package:food_app/screens/home_screen/HomeScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
            create: (context) => ProductProvider()),
        ChangeNotifierProvider<AddressProvider>(
            create: (context) => AddressProvider()),
        ChangeNotifierProvider<WishListProvider>(
            create: (context) => WishListProvider()),
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
        ChangeNotifierProvider<ReviewCartProvider>(
            create: (context) => ReviewCartProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => signin(),
        //   'signUp': (context) => signUp(),
        home: HomeScreen(),
      ),
    );
  }
}
