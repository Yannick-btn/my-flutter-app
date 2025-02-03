import 'package:flutter/material.dart';
import 'package:flutterapp/shared/bottom_nav.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Post Room',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
