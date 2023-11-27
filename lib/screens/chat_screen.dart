import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/widgets/chat/messages.dart';
import 'package:flutter_firebase/widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutterchat'),
        actions: [
          DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: const Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Logout')
                      ],
                    ),
                  ),
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance
      //       .collection('chats/YgfHceaQzrZPkd8q7MiK/messages')
      //       .snapshots(),
      //   builder: (ctx, streamSnapShot) {
      //     if (streamSnapShot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     final docs = streamSnapShot.data?.docs;
      //     return ListView.builder(
      //         itemCount: docs!.length,
      //         itemBuilder: (ctx, index) => Container(
      //               padding: const EdgeInsets.all(8),
      //               child: Text(docs[index]['text']),
      //             ));
      //   },
      // ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child:
            const Column(children: [Expanded(child: Messages()), NewMessage()]),
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       FirebaseFirestore.instance
      //           .collection('chats/YgfHceaQzrZPkd8q7MiK/messages')
      //           .add({'text': 'added'});
      //     },
      //     child: const Icon(Icons.add)),
    );
  }
}
