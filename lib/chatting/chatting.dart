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
          Expanded(child: _buildUserList()),
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
          return const Text('Error');
        }
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return ListView(
          children: (snapshot.data as List<Map<String, dynamic>>)
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );

        //return list views
      },
    );
  }

  // build individual list title for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all users exept current user

    return UserTile(
      text: userData["email"],
      onTap: () {
        // tape on user = go to chat
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              ),
            ));
      },
    );
  }
}
