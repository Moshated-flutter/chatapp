import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('main chat screen'),
      ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.all(15),
              child: Center(
                  child: Text(
                snapshot.data!.docs[index]['text'],
                style: TextStyle(fontSize: 15),
              )),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).cardColor,
                border: Border.all(
                  width: 1,
                  color: Colors.white,
                ),
              ),
            ),
            itemCount: snapshot.data!.docs.length,
          );
        },
        stream: FirebaseFirestore.instance
            .collection('Chats/Nb9e0vuGxcUFsfZZZjcr/Massages')
            .snapshots(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
