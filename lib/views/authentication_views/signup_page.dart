import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodcast/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodcast/services/authentication_service.dart';
import 'package:foodcast/views/authentication_views/authentication_wrapper.dart';
import 'package:foodcast/views/authentication_views/login_page.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
              'Sign Up',
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Email'),
                customInputBox('Email', Icon(Icons.email, color: Colors.white),
                    TextInputType.emailAddress, emailController,
                    obscureText: false),
                SizedBox(
                  height: 30,
                ),
                Text('Password'),
                customInputBox(
                  'Password',
                  Icon(Icons.lock, color: Colors.white),
                  TextInputType.visiblePassword,
                  passwordController,
                  obscureText: true,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuthenticationWrapper()));
                      return await AuthenticationService(FirebaseAuth.instance)
                          .signUp(
                              email: emailController.text,
                              password: passwordController.text);
                    },
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.white,
                    child: Text(
                      'SIGNUP',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have an Account? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        'Sign In',
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
