// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:esprit_spotted/models/message_model.dart';

class AppProvider extends ChangeNotifier {
  List<Message>? selectedMessages;

  void selectMessage(Message msg) {
    var sm = selectedMessages ?? [];
    sm.add(msg);
    selectedMessages = sm.toSet().toList();
    notifyListeners();
  }

  void unselectMessage(Message msg) {
    selectedMessages!.removeWhere((element) => element == msg);
    notifyListeners();
  }
}
