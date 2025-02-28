import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isCurrentUser
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.all(5.0),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
          left: 20.0,
          right: 20.0,
        ),
        child: Text(
          message,
          style: GoogleFonts.robotoMono(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
    );
  }
}
