import 'package:chatapp/screens/auth_screen/components/login_content.dart';
import 'package:chatapp/screens/auth_screen/login_background.dart/bottombackground.dart';
import 'package:chatapp/screens/auth_screen/login_background.dart/center/centerbackground.dart';
import 'package:chatapp/screens/auth_screen/login_background.dart/topbackground.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  var isloading = true;
  LoginScreen({required this.isloading, super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _subimitAuthData(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    final auth = FirebaseAuth.instance;
    late var authresult;
    try {
      if (isLogin) {
        authresult = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authresult = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on PlatformException catch (err) {
      var message = 'An error occured,please check your credintials';
      if (err.message != null) {
        message = err.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: topbackgroundwidget(screensize.width),
            top: -160,
            left: -30,
          ),
          Positioned(
            child: bottombackgroun(screensize.width),
            top: 450,
            left: -30,
          ),
          if (widget.isloading) Centerwidget(size: screensize),
          if (widget.isloading)
            Logincontent(
              submit: _subimitAuthData,
            ),
          if (!widget.isloading)
            Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
