import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esprit_spotted/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MessageService {
  final db = FirebaseFirestore.instance;

  Future postMessage(String message, VoidCallback onComplete) async {
    try {
      Message msg = Message(message: message, createdAt: DateTime.now());
      return await db.collection('messages').add(msg.toMap()).then((v) => onComplete());
    } on FirebaseException catch (e) {
      EasyLoading.showToast(e.message ?? "Something went wrong");
    }
  }

  Future<List<Message>> getMessages() async {
    List<Message> messages = [];
    var result = await db.collection('messages').get();
    for (var doc in result.docs) {
      messages.add(Message.fromMap(doc.data()));
    }
    messages.sort(((a, b) => b.createdAt.compareTo(a.createdAt)));

    return messages;
  }
}
