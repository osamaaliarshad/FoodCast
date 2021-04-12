import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodcast/pages/auth_pages/signup_page.dart';
import 'package:foodcast/repositories/auth_repository.dart';
import 'package:foodcast/widgets/constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:foodcast/services/authentication_service.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sidebarColor,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(30.0),
          children: [
            Text(
              'Sign In',
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Email'),
                customInputBox(
                    'Enter your email',
                    Icon(Icons.email, color: Colors.white),
                    TextInputType.emailAddress,
                    emailController,
                    obscureText: false),
                SizedBox(
                  height: 30,
                ),
                Text('Password'),
                customInputBox(
                  'Enter your password',
                  Icon(Icons.lock, color: Colors.white),
                  TextInputType.visiblePassword,
                  passwordController,
                  obscureText: true,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => print('Forgot Password Button Pressed'),
                    padding: EdgeInsets.only(right: 0.0),
                    child: Text(
                      'Forgot Password?',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () async {
                      return await context
                          .read(authRepositoryProvider)
                          .signInWithEmailandPassword(
                              emailController.text, passwordController.text);
                    },
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.white,
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an Account? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
