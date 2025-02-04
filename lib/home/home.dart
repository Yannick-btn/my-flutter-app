import 'package:flutter/material.dart';
import 'package:flutterapp/login/login.dart';
import 'package:flutterapp/post/post.dart';
import 'package:flutterapp/services/auth.dart';
import 'package:flutterapp/shared/nav_bar_wrapper.dart';

// check the useer autentication state and if there logged in show the post screen otherwise show the login screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        // if its waiting mean we are still loading some data
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading');
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('error'),
          );
        } else if (snapshot.hasData) {
          return NavBarWrapper();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
