import 'package:esprit_spotted/views/homepage.dart';
import 'package:esprit_spotted/views/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../src/theme_provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  initState() {
    super.initState();
    getAppTheme().then((_) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const Wrapper()));
      });
    });
  }

  Future<void> getAppTheme() async {
    Provider.of<DarkThemeProvider>(context, listen: false)
        .darkThemePref
        .getTheme()
        .then((value) => Provider.of<DarkThemeProvider>(context, listen: false).darkTheme = value);
  }

  void changeTheme(bool value) {
    Provider.of<DarkThemeProvider>(context, listen: false).darkTheme = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.remove_red_eye_outlined,
            size: 50,
          ),
          Text(
            "Esprit Spotted",
            style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 30),
          )
        ]),
      ),
    );
  }
}
