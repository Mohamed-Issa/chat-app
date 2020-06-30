import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('chat').snapshots(),
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDoc = chatSnapshots.data.documents;
        return ListView.builder(
            itemCount: chatDoc.length,
            itemBuilder: (ctx, index) {
              return Text(chatDoc[index]['text']);
            });
      },
    );
  }
}
