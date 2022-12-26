import 'package:esprit_spotted/firebase_options.dart';
import 'package:esprit_spotted/theme.dart';
import 'package:esprit_spotted/src/theme_provider.dart';
import 'package:esprit_spotted/views/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (_) => DarkThemeProvider())], child: const MyApp()));
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
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var border = const OutlineInputBorder(borderSide: BorderSide(width: 3, color: Color(0XFFD69031)));
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            IconButton(
                hoverColor: Colors.transparent,
                onPressed: () {
                  theme.darkTheme = !theme.darkTheme;
                },
                icon: Icon(
                  !theme.darkTheme ? Icons.dark_mode : Icons.light_mode,
                  color: Theme.of(context).iconTheme.color,
                ))
          ],
          leading: IconButton(
              onPressed: () {},
              hoverColor: Colors.transparent,
              icon: Icon(
                Icons.remove_red_eye_outlined,
                color: Theme.of(context).iconTheme.color,
              )),
          title: Text(
            "Esprit Spotted",
            style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.bold, color: Theme.of(context).hintColor),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Welcome to Esprit Spotted, this site was made by esprit students for esprit students to post messages anonymously ",
                        style: TextStyle(fontFamily: "Inter"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextField(
                            maxLines: 8,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                                filled: true,
                                focusColor: Theme.of(context).primaryColor,
                                hoverColor: Theme.of(context).primaryColor.withOpacity(0.3),
                                enabledBorder: border,
                                border: border,
                                focusedBorder: border)),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {},
                        onHover: (val) {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: const BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Send Message",
                                style: TextStyle(fontFamily: "Inter", color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Spacer(),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: "Don't trust us?\nWe're opensource at ",
                              style: TextStyle(
                                fontFamily: "Inter",
                                color: Theme.of(context).hintColor,
                              ),
                              children: [
                                TextSpan(text: "github.com", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor))
                              ]))
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
