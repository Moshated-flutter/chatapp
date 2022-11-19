import 'package:chatapp/screens/auth_screen/login_screen.dart';
import 'package:chatapp/screens/chatScreen.dart';
import 'package:chatapp/screens/loadingScreen.dart';
import 'package:chatapp/utils/constrans.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter chat app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: kbackground,
          textTheme:
              Theme.of(context).textTheme.apply(bodyColor: kprimarcolors),
          fontFamily: 'Montserrat',
          cardColor: Colors.grey[100]),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot snapshotstream) {
                if (snapshotstream.hasData) {
                  return new ChatScreen();
                }
                return new LoginScreen(isloading: false);
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoginScreen(
              isloading: true,
            );
          }
          return LoadingScreen();
        },
      ),
    );
  }
}
