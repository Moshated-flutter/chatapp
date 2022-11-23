import 'package:chatapp/widgets/chats/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Massages extends StatelessWidget {
  const Massages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final user = FirebaseAuth.instance.currentUser;
        return ListView.builder(
          reverse: true,
          itemBuilder: (context, index) => Messagebubble(
              snapshot.data!.docs[index]['text'],
              snapshot.data!.docs[index]['userID'] == user!.uid,
              ValueKey(snapshot.data!.docs[index].id),
              snapshot.data!.docs[index]['username'],
              snapshot.data!.docs[index]['userImage']),
          itemCount: snapshot.data!.docs.length,
        );
      },
      stream: FirebaseFirestore.instance
          .collection('Chats/Nb9e0vuGxcUFsfZZZjcr/Massages')
          .orderBy('datetime', descending: true)
          .snapshots(),
    );
  }
}
