// ignore_for_file: depend_on_referenced_packages

import 'package:chatapp/screens/auth_screen/components/login_content.dart';
import 'package:chatapp/screens/auth_screen/login_background.dart/bottombackground.dart';
import 'package:chatapp/screens/auth_screen/login_background.dart/center/centerbackground.dart';
import 'package:chatapp/screens/auth_screen/login_background.dart/topbackground.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  var _isloading = false;
  Future<void> _subimitAuthData(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    final auth = FirebaseAuth.instance;
    UserCredential authresult;
    try {
      setState(() {
        _isloading = true;
      });
      if (isLogin) {
        authresult = (await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ));
      } else {
        authresult = (await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ));
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authresult.user!.uid)
            .set({
          'username': username,
          'email': email,
          'password': password,
        });
      }
    } on PlatformException catch (err) {
      var message = 'An error occured,please check your credintials';
      if (err.message != null) {
        message = err.message!;
      }
      setState(() {
        _isloading = false;
      });
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    } catch (error) {
      setState(() {
        _isloading = false;
      });
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
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
            top: -160,
            left: -30,
            child: topbackgroundwidget(screensize.width),
          ),
          Positioned(
            top: 450,
            left: -30,
            child: bottombackgroun(screensize.width),
          ),
          Centerwidget(size: screensize),
          if (!widget.isloading)
            Logincontent(
              submit: _subimitAuthData,
              loadingindicator: _isloading,
            ),
          if (widget.isloading)
            // ignore: prefer_const_constructors
            Center(
              child: const CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
