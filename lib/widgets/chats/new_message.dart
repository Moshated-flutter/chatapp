import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  var _enteredMessages = '';
  final _sendingController = new TextEditingController();
  Future<void> _sendMessages() async {
    final user = await FirebaseAuth.instance.currentUser;
    final userdata = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance
        .collection('Chats/Nb9e0vuGxcUFsfZZZjcr/Massages')
        .add(
      {
        'text': _enteredMessages,
        'datetime': Timestamp.now(),
        'userID': user.uid,
        'username': userdata['username'],
        'userImage': userdata['imageUrl'],
      },
    );
    setState(() {
      _enteredMessages = '';
      _sendingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _sendingController,
              onChanged: (value) {
                setState(() {
                  _enteredMessages = value;
                });
              },
              decoration: InputDecoration(
                label: Text('Send a message'),
              ),
            ),
          ),
          IconButton(
            onPressed: _enteredMessages.trim().isEmpty ? null : _sendMessages,
            icon: Icon(Icons.send),
            color: Colors.green,
          )
        ],
      ),
    );
  }
}
