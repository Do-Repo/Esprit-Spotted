import 'package:esprit_spotted/services/auth_service.dart';
import 'package:esprit_spotted/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showAuthDialog(BuildContext context) async {
  String username = "", password = "";
  AuthService authService = AuthService();
  final formKey = GlobalKey<FormState>();

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Sign in'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  onChanged: (value) => username = value,
                  cursorColor: Theme.of(context).primaryColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Field required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Username",
                      floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
                      border: border,
                      focusedBorder: border,
                      enabledBorder: border,
                      disabledBorder: border),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onChanged: (value) => password = value,
                  obscureText: true,
                  cursorColor: Theme.of(context).primaryColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Field required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
                      labelText: "Password",
                      border: border,
                      focusedBorder: border,
                      enabledBorder: border,
                      disabledBorder: border),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Sign in',
              style: GoogleFonts.inter(color: Theme.of(context).primaryColor),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(context).pop();
                EasyLoading.show();
                authService.signInWithEmailAndPassword(username, password, context).then((value) => EasyLoading.dismiss());
              }
            },
          ),
        ],
      );
    },
  );
}
