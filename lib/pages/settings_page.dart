import 'package:flutter/material.dart';
import 'package:foodcast/repositories/auth_repository.dart';
import 'package:foodcast/widgets/constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
            child: ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                return await context.read(authRepositoryProvider).signOut();
              },
              style: ElevatedButton.styleFrom(
                primary: sidebarColor, // background
                onPrimary: Colors.black, // foreground
              ),
              child: Text('Sign out'),
            ),
          ),
        ],
      ),
    );
  }
}
