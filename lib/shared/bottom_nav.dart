import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTabChange;

  const BottomNavBar({
    super.key,
    required this.pageIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
      icons: [
        FontAwesomeIcons.envelope,
        FontAwesomeIcons.comment,
        FontAwesomeIcons.user,
      ],
      activeIndex: pageIndex,
      inactiveColor: Colors.black,
      activeColor: Colors.blueAccent,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 0,
      rightCornerRadius: 0,
      iconSize: 25,
      elevation: 0,
      onTap: onTabChange,
    );
  }
}
