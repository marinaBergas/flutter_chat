// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  // final String userId;
  final String username;
  const MessageBubble(
      {super.key,
      required this.message,
      required this.isMe,
      // required this.userId,
      required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isMe
                  ? Colors.grey[300]
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: isMe
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  bottomRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12)),
            ),
            width: 140,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  //stream builder for fetch on change
                  //to fetch once use futurebuilder
                  // FutureBuilder<DocumentSnapshot>(
                  //     future: FirebaseFirestore.instance
                  //         .collection('users')
                  //         .doc(userId)
                  //         .get(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.waiting) {
                  //         return const Text('Loading ...');
                  //       }
                  //       return Text(
                  //         snapshot.data!['username'],
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             color: isMe
                  //                 ? Colors.black
                  //                 : Theme.of(context)
                  //                     .textTheme
                  //                     .titleSmall
                  //                     ?.color),
                  //       );
                  //     }),
                  Text(username),
                  Text(message,
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                      style: TextStyle(
                          color: isMe
                              ? Colors.black
                              : Theme.of(context).textTheme.titleSmall?.color)),
                ]),
          ),
        ]);
  }
}
