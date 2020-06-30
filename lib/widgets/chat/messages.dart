import 'package:chatapp/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDoc = chatSnapshots.data.documents;
        return ListView.builder(
            itemCount: chatDoc.length,
            reverse: true,
            itemBuilder: (ctx, index) {
              return MessageBubble(chatDoc[index]['text']);
            });
      },
    );
  }
}
