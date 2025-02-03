import 'package:flutter/material.dart';
import 'package:flutterapp/about/about.dart';
import 'package:flutterapp/profile/profile.dart';
import 'package:flutterapp/login/login.dart';
import 'package:flutterapp/home/home.dart';
import 'package:flutterapp/post/post.dart';
import 'package:flutterapp/shared/nav_bar_wrapper.dart'; // Import the NavBarWrapper

var appRoutes = {
  '/': (context) => const HomeScreen(), // Démarre sur HomeScreen
  '/about': (context) => const AboutScreen(),
  '/profile': (context) => NavBarWrapper(), // Use NavBarWrapper for profile
  '/login': (context) => const LoginScreen(),
  '/post': (context) => NavBarWrapper(), // Use NavBarWrapper for post
  '/chat': (context) => NavBarWrapper(), // Use NavBarWrapper for chat
};
