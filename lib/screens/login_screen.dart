import 'package:diaryapp/providers/user_state_provider.dart';
import 'package:diaryapp/screens/base_scaffold.dart';
import 'package:diaryapp/tools/logging_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget signIn({required UserState user}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              iconSize: 40,
              icon: Image.asset(
                'assets/images/google_icons/android_dark_sq_ctn@2x.png',
                scale: 2,
              ),
              onPressed: () async {
                 bool success = await LogHandler.signInWithGoogle();
                if (success) {
                  dev.log("  Google sign in successfully!");
                } else {
                  dev.log("  Google sign in failed !");
                }
              },
            ),
          ),

          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              iconSize: 40,
              icon: Image.asset(
                'assets/images/github.jpg',
                scale: 2.15,
              ),
              onPressed: () async {
                 bool success = await LogHandler.signInWithGithub(context: context);
                if (success) {
                  dev.log("  Github sign in ok!");
                } else {
                  dev.log("  Github sign in failed !");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget signOut({required UserState user}) {
    return Center(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                width: 1.5, color: Colors.black54)),
        child: Image.network(
            user.photoURL.toString()),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(user.displayName),
      const SizedBox(
        height: 20,
      ),
      Text(user.email),
      const SizedBox(
        height: 30,
      ),
      ElevatedButton(
          onPressed: () async {
            await LogHandler.userLoggingOut();
          },
          child: const Text('Logout'))
    ],
  ),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
      builder: (context, state, child) {
        return BaseScaffold(
            title: 'SignIn',
            body:(state.logstate == LogState.notLogged)
                      ? signIn(user: state)
                      : signOut(user: state),
        );       
      }
    );
  }
}