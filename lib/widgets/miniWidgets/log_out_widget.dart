
import 'package:diaryapp/design/tanuki_colors.dart';
import 'package:diaryapp/providers/user_state_provider.dart';
import 'package:diaryapp/tools/logging_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LogOutWidget extends StatelessWidget {

  const LogOutWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer(
      builder: (context, UserState user, child) {
        return TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(0)),
          ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirmation'),
              content: const Text('Log out ?'),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: const Text('Logout'),
                  onPressed: () {
                    LogHandler.userLoggingOut();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(2.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: TanukiColor.PRIMARY,
        ),
        child: CircleAvatar(
          backgroundImage: NetworkImage(user.photoURL),
          radius: 18,
        ),
      ),
    );
      }
    );
  }
  
}