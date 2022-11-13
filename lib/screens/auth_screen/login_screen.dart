import 'package:chatapp/screens/auth_screen/components/login_content.dart';
import 'package:chatapp/screens/auth_screen/login_background.dart/bottombackground.dart';
import 'package:chatapp/screens/auth_screen/login_background.dart/center/centerbackground.dart';
import 'package:chatapp/screens/auth_screen/login_background.dart/topbackground.dart';
import 'package:chatapp/utils/constrans.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          Centerwidget(size: screensize),
          Logincontent(),
        ],
      ),
    );
  }
}
