import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/screens/auth_screen/animations/change_screen_animation.dart';
import 'package:chatapp/screens/auth_screen/components/login_content.dart';
import 'package:chatapp/screens/auth_screen/login_screen.dart';
import 'package:chatapp/screens/chatScreen.dart';
import 'package:chatapp/screens/imageprofile/image_sceen.dart';
import 'package:chatapp/screens/loadingScreen.dart';
import 'package:chatapp/utils/constrans.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  static bool newAccount = false;
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
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot snapshotstream) {
                if (snapshotstream.hasData) {
                  if (newAccount) {
                    return ImageScreen();
                  }
                  return new ChatScreen();
                }
                return new LoginScreen(isloading: false);
              },
            );
          }

          return LoginScreen(
            isloading: true,
          );
        },
      ),
      routes: {
        ChatScreen.routename: (context) => ChatScreen(),
        ImageScreen.routename: (context) => ImageScreen(),
      },
    );
  }
}
