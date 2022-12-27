import 'package:esprit_spotted/firebase_options.dart';
import 'package:esprit_spotted/services/auth_service.dart';
import 'package:esprit_spotted/theme.dart';
import 'package:esprit_spotted/src/theme_provider.dart';
import 'package:esprit_spotted/views/splash_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    StreamProvider<User?>.value(value: AuthService().onAuthStateChanged, initialData: null),
    ChangeNotifierProvider(create: (_) => DarkThemeProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeValue = Provider.of<DarkThemeProvider>(context);

    return MaterialApp(
      title: 'Esprit Spotted',
      debugShowCheckedModeBanner: false,
      theme: Styles.themeData(themeValue.darkTheme, context),
      home: const Splash(),
      builder: EasyLoading.init(),
    );
  }
}
