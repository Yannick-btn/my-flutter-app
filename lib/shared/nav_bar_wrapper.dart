import 'package:flutter/material.dart';
import 'package:flutterapp/post/post.dart';
import 'package:flutterapp/chatting/chatting.dart';
import 'package:flutterapp/profile/profile.dart';
import 'package:flutterapp/shared/bottom_nav.dart';

class NavBarWrapper extends StatefulWidget {
  const NavBarWrapper({super.key});

  @override
  State<NavBarWrapper> createState() => _NavBarWrapperState();
}

class _NavBarWrapperState extends State<NavBarWrapper> {
  // Définir une page par défaut
  int pageIndex = 0;

  final List<Widget> pages = [
    // index 0
    PostScreen(),
    // index 1
    ChattingScreen(),
    // index 2
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack garde toutes les pages en mémoire mais n’affiche que celle dont l'index correspond
      body: IndexedStack(
        // Affiche seulement la page de l'index
        index: pageIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavBar(
        // Quand l'utilisateur appuie sur une icône, change la page liée à l'index
        pageIndex: pageIndex,
        onTabChange: (index) {
          // Met à jour l'interface lorsqu'on appuie sur l'un des boutons
          setState(() {
            pageIndex = index;
          });
        },
      ),
    );
  }
}
