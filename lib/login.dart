import 'dart:async';

import 'package:buyinglist/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in/testing.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.userChanges().listen((User? user) {
      if (user != null) {
        goToHome(context, user);
      }
    });

    return Scaffold(
      body: _buildBody(),
    );
  }

  void goToHome(BuildContext context, User user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage(user: user)),
    );
  }

  Future<void> _handleSignIn() async {
    try {
      await signInWithGoogle();
    } catch (error) {
      print(error);
    }
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 20.0, bottom: 100.0)),
        Text(
          "Bem-vindo à Listas de Compras",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        Text('Conecte-se com sua conta Google'),
        Padding(padding: EdgeInsets.only(top: 20.0, bottom: 40.0)),
        Container(
          width: 60.0,
          height: 60.0,
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(height: 100.0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Ink.image(
                image: AssetImage('assets/images/google_logo.png'),
                child: InkWell(
                  onTap: _handleSignIn,
                ),
              ),
            ),
          ),
        ),
        Text('Google'),
        Expanded(child: Container()),
        Padding(padding: EdgeInsets.only(bottom: 20.0)),
      ],
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    var completer = new Completer<UserCredential>();
    if (googleUser == null) return completer.future;
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
