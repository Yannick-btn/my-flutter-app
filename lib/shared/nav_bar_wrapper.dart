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
  int pageIndex = 0;

  final List<Widget> pages = [
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
      bottomNavigationBar: BottomNavBar(
        pageIndex: pageIndex,
        onTabChange: (index) {
          setState(() {
            pageIndex = index;
          });
        },
      ),
    );
  }
}
