import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodcast/services/authentication_service.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: RaisedButton(
              onPressed: () async {
                Navigator.pop(context);
                return await AuthenticationService(FirebaseAuth.instance)
                    .signOut();
              },
              child: Text('Sign out'),
            ),
          ),
        ],
      ),
    );
  }
}
