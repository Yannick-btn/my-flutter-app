import 'package:flutterapp/about/about.dart';
import 'package:flutterapp/login/login.dart';
import 'package:flutterapp/home/home.dart';
import 'package:flutterapp/shared/nav_bar_wrapper.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/about': (context) => const AboutScreen(),
  '/profile': (context) => NavBarWrapper(),
  '/login': (context) => const LoginScreen(),
  '/post': (context) => NavBarWrapper(),
  '/chat': (context) => NavBarWrapper(),
};
