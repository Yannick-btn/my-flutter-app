import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/about/about.dart';
import 'package:flutterapp/components/user_tile.dart';
import 'package:flutterapp/profile/screens/credit.dart';
import 'package:flutterapp/profile/screens/setting.dart';
import 'package:flutterapp/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class ProfileScreen extends StatelessWidget {
  //final void function()? onTap;
  const ProfileScreen({
    super.key,

    //required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          ElevatedButton(
            child: const Text('Sign Out'),
            onPressed: () async {
              await AuthService().signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            UserTile(
              text: "Settings",
              leadingIcon: CupertinoIcons.settings,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SettingScreen()),
                );
              },
            ),
            UserTile(
              text: "Credit",
              leadingIcon: CupertinoIcons.doc_text_search,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CreditScreen()),
                );
              },
            ),
            UserTile(
              text: "À propos",
              leadingIcon: CupertinoIcons.exclamationmark_circle,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AboutScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
