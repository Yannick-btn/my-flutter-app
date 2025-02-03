import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutterapp/post/post.dart';
import 'package:flutterapp/chatting/chatting.dart';
import 'package:flutterapp/profile/profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;

  List<Widget> pages = [
    PostScreen(),
    ChattingScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: pages,
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          FontAwesomeIcons.envelope,
          FontAwesomeIcons.comment,
          FontAwesomeIcons.user,
        ],
        activeIndex: pageIndex,
        inactiveColor: Colors.black,
        activeColor: Colors.blueAccent,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        iconSize: 25,
        elevation: 0,
        onTap: (index) {
          if (mounted) {
            setState(() {
              pageIndex = index;
            });
          }
        },
      ),
    );
  }
}
