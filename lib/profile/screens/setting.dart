import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // FocusNode pour le champ de texte

  // fonction pour mettre à jour le displayName dans Firestore
  void updateDisplayNameFirestore(String newDisplayName) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      print('Utilisateur non connecté');
      return;
    }

    // mise à jour du displayName dans Firestore
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update({
        // Mise à jour du displayName
        'displayName': newDisplayName,
      });
      print('Nouveau nom : $newDisplayName');
    } catch (error) {
      print('Erreur lors de la mise à jour dans Firestore : $error');
    }
  }

  // fonction pour mettre à jour le displayName dans Firebase Auth
  void updateDisplayNameInAuth(String newDisplayName) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      print('Utilisateur non connecté');
      return;
    }

    try {
      // Mise à jour du nom dans Firebase Auth
      await currentUser.updateDisplayName(newDisplayName);
      print('Nom mis à jour dans Firebase Auth : $newDisplayName');
    } catch (error) {
      print('Erreur lors de la mise à jour dans Firebase Auth : $error');
    }
  }

  // fonction de mise à jour du nom
  void _updateDisplayName() {
    String newDisplayName = _nameController.text;

    if (newDisplayName.isNotEmpty) {
      // Mettre à jour Firestore et Firebase Auth
      updateDisplayNameFirestore(newDisplayName);
      updateDisplayNameInAuth(newDisplayName);

      // Effacer le texte dans le TextField après la mise à jour
      _nameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Lorsque l'utilisateur tape ailleurs, on retire le focus du champ de texte
        _focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                focusNode: _focusNode, // Associer le FocusNode au TextField
                style: GoogleFonts.robotoMono(
                  color: Theme.of(context).colorScheme.tertiary,
                  letterSpacing: 4.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Entrez votre nouveau nom',
                  labelStyle: GoogleFonts.robotoMono(
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateDisplayName, // Appel de la méthode
                child: Text(
                  'Mettre à jour votre nom',
                  style: GoogleFonts.robotoMono(
                    letterSpacing: 2.0,
                  ), // Texte du bouton
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
