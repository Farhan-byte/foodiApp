import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:food_app/providers/User_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:food_app/screens/home_screen/HomeScreen.dart';
import 'package:provider/provider.dart';

class signin extends StatefulWidget {
  @override
  _signinState createState() => _signinState();
}

class _signinState extends State<signin> {
  UserProvider userProvider;
  Future<void> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;
      // print("signed in " + user.displayName);
      userProvider.addUserData(
          currentUser: user,
          userEmail: user.email,
          userImage: user.photoURL,
          userName: user.displayName);
      return user;
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/vegiback.jpg'),
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    'Sign In to Continue',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Vegi',
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                              blurRadius: 5,
                              color: Colors.green.shade900,
                              offset: Offset(3, 3))
                        ]),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SignInButton(
                    Buttons.Apple,
                    text: "Sign in with Apple",
                    onPressed: () {},
                  ),

// with custom text
                  SignInButton(
                    Buttons.Google,
                    text: "Sign in with Google",
                    onPressed: () async {
                      await _googleSignUp().then((value) =>
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen())));
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'By signing in you agree to our',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Terms and Privcy Policy',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
