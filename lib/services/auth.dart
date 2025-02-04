import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // you want to use a stream when you want the ui to react to an of state change but your not sure when this change is gonna occure
  final userStream = FirebaseAuth.instance.authStateChanges();

  // usefull when you have an event like when a user clicks on a button and you need to chek there autentication state in that moment
  final user = FirebaseAuth.instance.currentUser;

  // Anonnymous Firebase login
  Future<void> anonLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      // handle error
    }
  }

  Future<void> singOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
