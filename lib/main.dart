import 'package:chatapp/screens/auth_screen/login_screen.dart';
import 'package:chatapp/utils/constrans.dart';

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
      // home: FutureBuilder(
      //   future: Firebase.initializeApp(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return LoadingScreen();
      //     }
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       return ChatScreen();
      //     }
      //     return LoadingScreen();
      //   },
      // ),
      home: LoginScreen(),
    );
  }
}
