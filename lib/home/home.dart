import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text(
            'Chatting',
            // import labelMerdium created in theme.dart
            // Theme.of is to acces it
            style: Theme.of(context).textTheme.labelMedium,
          ),

          // Navigator contain mutiple methode to manage routing and navigation in the app
          // most commun method are : push and pop
          // push will add a new screen on the top of the ui
          // pop will naviguate backward in history by removing that screen from the top
          onPressed: () => Navigator.pushNamed(context, '/chat'),
        ),
      ),
    );
  }
}
