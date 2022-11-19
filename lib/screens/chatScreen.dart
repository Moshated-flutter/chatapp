import 'package:chatapp/widgets/chats/masseges.dart';
import 'package:chatapp/widgets/chats/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('chat screen'),
        actions: [
          DropdownButton(
            elevation: 0,
            underline: null,
            borderRadius: BorderRadius.zero,
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 5),
                      Text('Log Out'),
                    ],
                  ),
                ),
              ),
            ],
            onChanged: (value) {
              if (value == 'logout') {
                // ChangeScreenAnimations.currentScreen = Screens.createAccount;
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Massages()),
          NewMessages(),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
