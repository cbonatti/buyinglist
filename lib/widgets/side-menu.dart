import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in/widgets.dart';

import '../login.dart';
import 'rounded-image.dart';

class SideMenuPage extends StatelessWidget {
  final User currentUser;

  SideMenuPage(this.currentUser);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.userChanges().listen((User? user) {});

    Future<void> _handleSignOut() => auth.signOut();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(''),
            decoration: BoxDecoration(
              color: Colors.teal,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/shopping_cart.png'),
              ),
            ),
          ),
          ListTile(
            leading: RoundedImage(imagePath: currentUser.photoURL),
            title: Text(currentUser.displayName ?? ''),
            subtitle: Text(currentUser.email ?? ''),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () async => {
              await _handleSignOut(),
              Navigator.pop(context),
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              )
            },
          ),
        ],
      ),
    );
  }
}
