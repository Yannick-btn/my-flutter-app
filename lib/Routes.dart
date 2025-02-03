// importent les fichiers Dart qui contiennent les écrans (ou widgets) de votre application.
import 'package:flutterapp/about/about.dart';
import 'package:flutterapp/profile/profile.dart';
import 'package:flutterapp/login/login.dart';
import 'package:flutterapp/home/home.dart';
import 'package:flutterapp/post/post.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(), // Démarre sur HomeScreen
  '/about': (context) => const AboutScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/login': (context) => const LoginScreen(),
  '/post': (context) =>
      const PostScreen(), // Page où la BottomNavBar sera visible
};
