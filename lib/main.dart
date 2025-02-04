import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/theme.dart';
import 'package:flutterapp/shared/bottom_nav.dart';
import 'package:flutterapp/Routes.dart';
import 'package:flutterapp/home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Text('error'),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          FirebaseAuth.instance.setLanguageCode('fr');
          return MaterialApp(
            routes: appRoutes,
            theme: appTheme,
            //home: const HomeScreen(),
          );
        }

        return Directionality(
          textDirection: TextDirection.ltr,
          child: Text('loading'),
        );
      },
    );
  }
}
