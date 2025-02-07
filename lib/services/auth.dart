import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // you want to use a stream when you want the ui to react to an of state change but your not sure when this change is gonna occure
  final userStream = FirebaseAuth.instance.authStateChanges();

  // usefull when you have an event like when a user clicks on a button and you need to chek there autentication state in that moment
  final user = FirebaseAuth.instance.currentUser;

  // Anonnymous Firebase login
  Future<void> anonLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException {
      // handle error
    }
  }

  Future<void> singOut() async {
    await FirebaseAuth.instance.signOut();

    await GoogleSignIn().disconnect();
  }

  // Google login
  Future<void> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in user with credential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Save user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(
              {
            'uid': userCredential.user!.uid,
            'email': userCredential.user!.email,
          },
              SetOptions(
                  merge:
                      true)); // Merge pour éviter d'écraser les données existantes
    } on FirebaseAuthException catch (e) {
      print('Erreur de connexion Google: ${e.message}');
    }
  }

  getCurrentUser() {}
}
