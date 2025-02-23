import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutterapp/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min, // Évite l’espace entre les textes
              children: [
                Text(
                  'Nex.',
                  style: GoogleFonts.leagueSpartan(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 150.0,
                    fontWeight: FontWeight.bold,
                    height: 0.8,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'The Nex. Generation',
                  style: GoogleFonts.leagueSpartan(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    height: 0.8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 100), // Espace avant les boutons
            LoginButton(
              icon: FontAwesomeIcons.userNinja,
              text: 'Continue as Guest',
              loginMethod: AuthService().anonLogin,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 80), // Espace entre les boutons
            LoginButton(
              text: 'Sign in with Google',
              icon: FontAwesomeIcons.google,
              color: Colors.lightBlue,
              loginMethod: AuthService().googleLogin,
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final VoidCallback loginMethod;

  const LoginButton({
    required this.text,
    required this.icon,
    required this.color,
    required this.loginMethod,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        label: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: color,
        ),
        onPressed: loginMethod,
      ),
    );
  }
}
