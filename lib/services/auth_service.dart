import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get onAuthStateChanged {
    return _auth.authStateChanges();
  }

  Future signInWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        EasyLoading.showToast("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        EasyLoading.showToast("Wrong password provided for that user.");
      } else {
        EasyLoading.showToast(e.message ?? "Something went wrong");
      }
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return null;
    }
  }
}
