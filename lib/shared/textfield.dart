import 'package:flutter/material.dart';

// Définition de la classe MyTextField qui hérite de StatelessWidget.
class MyTextField extends StatelessWidget {
  // Déclaration des variables nécessaires pour le widget.
  final String
      hintText; // Texte d'indication à afficher dans le champ de texte.
  final bool
      obscureText; // Permet de masquer le texte (utile pour les mots de passe).
  final TextEditingController
      controller; // Contrôleur pour récupérer et manipuler le texte saisi.

  // Constructeur pour initialiser les variables.
  const MyTextField({
    super.key, // Clé pour identifier le widget.
    required this.hintText, // Le texte d'indication est requis.
    required this.obscureText, // Le champ texte doit savoir s'il faut masquer le texte.
    required this.controller, // Le contrôleur est requis pour gérer le texte.
  });

  @override
  Widget build(BuildContext context) {
    // Retourne un widget Padding qui contient le champ de texte.
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal:
              25.0), // Ajoute un espacement horizontal de 25 pixels autour du champ.
      child: TextField(
        // Si true, le texte est masqué
        obscureText: obscureText,
        // Associe le contrôleur à ce champ de texte.
        controller: controller,
        decoration: InputDecoration(
          // Bordure du champ de texte lorsque l'utilisateur n'est pas focalisé sur celui-ci.
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .tertiary), // Utilisation de la couleur secondaire du thème pour la bordure.
          ),
          // Bordure du champ de texte lorsque l'utilisateur est focalisé dessus.
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .primary), // Utilisation de la couleur principale du thème pour la bordure.
          ),
          // Définit la couleur de fond du champ de texte.
          fillColor: Theme.of(context).colorScheme.secondary,
          // Active la couleur de fond définie plus haut.
          filled: true,
          // Le texte d'indication affiché dans le champ lorsqu'il est vide.
          hintText: hintText,
          // Style du texte d'indication
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
