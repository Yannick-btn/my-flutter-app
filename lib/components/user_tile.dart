import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTile extends StatelessWidget {
  final String text;
  final IconData leadingIcon;
  final void Function()? onTap;
  const UserTile({
    super.key,
    required this.text,
    required this.leadingIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8.0, horizontal: 16.0), // Ici vous ajoutez le margin
        child: Container(
          decoration: BoxDecoration(
            //color: Theme.of(context).colorScheme.primary,
            border: Border(
                bottom:
                    BorderSide(color: Theme.of(context).colorScheme.primary)),
            //borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
              ),
              // icon dynamique
              Icon(
                leadingIcon,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 8), // Ajout d'un espace entre l'icône et le texte
              // user name
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  text,
                  style: GoogleFonts.robotoMono(
                      color: Theme.of(context).colorScheme.tertiary),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_right,
                size: 30.0,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
