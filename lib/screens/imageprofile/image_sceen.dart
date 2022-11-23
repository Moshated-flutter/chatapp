import 'dart:io';

import 'package:chatapp/main.dart';
import 'package:chatapp/screens/auth_screen/login_background.dart/bottombackground.dart';
import 'package:chatapp/screens/auth_screen/login_background.dart/center/centerbackground.dart';
import 'package:chatapp/screens/auth_screen/login_background.dart/topbackground.dart';
import 'package:chatapp/screens/chatScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageScreen extends StatefulWidget {
  static const routename = '/imagescreen';
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  File? _imagestored;
  var imageIsLoaded = false;

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
          Center(
            child: Container(
              height: 200,
              width: 250,
              decoration: const BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Please set up an image profle:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.all(15),
                    ),
                    onPressed: () async {
                      final picker = ImagePicker();
                      final imagepicked = await picker.pickImage(
                        source: ImageSource.gallery,
                        maxHeight: 150,
                        imageQuality: 40,
                      );
                      if (imagepicked == null) {
                        return;
                      }
                      _imagestored = File(imagepicked.path);
                      setState(() {
                        imageIsLoaded = true;
                      });
                    },
                    child: const Text(
                      'Chosse from your gallery',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.all(15),
                    ),
                    onPressed: () async {
                      final picker = ImagePicker();
                      final imagepicked = await picker.pickImage(
                        source: ImageSource.camera,
                        maxHeight: 150,
                        imageQuality: 40,
                      );
                      if (imagepicked == null) {
                        return;
                      }
                      _imagestored = File(imagepicked.path);
                      setState(() {
                        imageIsLoaded = true;
                      });
                    },
                    child: const Text(
                      'use your camera',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 150,
            right: 120,
            child: !imageIsLoaded
                ? const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(
                      'assets/images/dummy_profile.png',
                    ),
                  )
                : CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(_imagestored as File),
                  ),
          ),
          if (imageIsLoaded)
            Positioned(
              left: 125,
              bottom: 50,
              child: ElevatedButton.icon(
                label: const Text('go to chat screen'),
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  final ref = FirebaseStorage.instance
                      .ref()
                      .child('user_images')
                      .child(user!.uid + '.jpg');
                  ref.putFile(_imagestored!).whenComplete(() async {
                    MyApp.newAccount = false;
                    final url = await ref.getDownloadURL();
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .update({
                      'imageUrl': url,
                    });

                    Navigator.of(context).pushNamedAndRemoveUntil(
                        ChatScreen.routename, (route) => false);
                  });
                },
                icon: const Icon(
                  Icons.check,
                ),
              ),
            )
        ],
      ),
    );
  }
}
