import 'package:flutter/material.dart';
import 'package:flutterapp/chatting/chat_page.dart';
import 'package:flutterapp/components/user_tile.dart';
import 'package:flutterapp/services/auth.dart';
import 'package:flutterapp/services/chat.dart';

class ChattingScreen extends StatelessWidget {
  ChattingScreen({super.key});

  // chat and auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat Room")),
      body: Column(
        children: [
          Expanded(
            child: _buildUserList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text('Erreur de chargement');
        }
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Chargement...');
        }
        return ListView(
          children: (snapshot.data as List<Map<String, dynamic>>)
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  // build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all users except current user
    return UserTile(
      text: userData["displayName"],
      leadingIcon: Icons.person,
      onTap: () {
        // tap on user = go to chat
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
                receiverName: userData["displayName"],
              ),
            ));
      },
    );
  }
}
