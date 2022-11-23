import 'package:flutter/material.dart';

class Messagebubble extends StatelessWidget {
  final bool isme;
  final String message;
  final Key messagekey;
  final String userName;
  final String imageurl;

  Messagebubble(
      this.message, this.isme, this.messagekey, this.userName, this.imageurl);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isme ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isme)
          CircleAvatar(
            backgroundImage: NetworkImage(imageurl),
          ),
        Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15),
              bottomLeft:
                  isme ? const Radius.circular(15) : const Radius.circular(0),
              bottomRight:
                  !isme ? const Radius.circular(15) : const Radius.circular(0),
            ),
            color: !isme ? Colors.purple : Colors.blue,
            border: Border.all(
              width: 1,
              color: Colors.white,
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        if (isme)
          CircleAvatar(
            backgroundImage: NetworkImage(imageurl),
          ),
      ],
    );
  }
}
