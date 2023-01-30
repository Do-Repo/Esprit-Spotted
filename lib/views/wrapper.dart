import 'package:esprit_spotted/views/dashboard.dart';
import 'package:esprit_spotted/views/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context, listen: true);
    if (user != null) {
      return const Dashboard();
    } else {
      return const Homepage();
    }
  }
}
