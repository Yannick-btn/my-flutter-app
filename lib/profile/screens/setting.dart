import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/main.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final TextEditingController _nameController = TextEditingController();

  // fonction pour mettre à jour le displayName dans Firestore
  void updateDisplayNameFirestore(String newDisplayName) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      print('utilisateur non connecté');
      return;
    }

    // mise a jour du displayName dans Firestore
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update({
        // Mis a jour du displayName
        'displayName': newDisplayName,
      });
      print('nouveau nom : $newDisplayName');
    } catch (error) {
      print('Erreur lors de la mise à jour dans Firestore : $error ');
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Entrez votre nouveau nom',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _updateDisplayName,
              child: const Text('Mettre a jour le nom'),
            ),
          ],
        ),
      ),
    );
  }
}
