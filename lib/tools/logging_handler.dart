import 'package:diaryapp/config/env.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as dev;

class LogHandler {

  LogHandler._privateConstructor();

  static Future<bool> signInWithGoogle() async {
      try {
        dev.log('before await GoogleSignIn().signIn()');
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        dev.log('after await GoogleSignIn().signIn()');

        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;
        dev.log("GoogleSignInAuthentication? googleAuth = ${googleAuth.toString()}");

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        dev.log("GoogleAuthProvider.credential = ${credential.toString()}");

        await FirebaseAuth.instance.signInWithCredential(credential);
        return true;
      } on Exception catch (e) {
        dev.log('exception->$e');
        return false;
      }
    }

  static Future<bool> signInWithGithub({ required BuildContext context}) async {
      try {
        final GitHubSignIn gitHubSignIn = GitHubSignIn(
          clientId: Env.githubClientId,
          clientSecret: Env.githubSecretKey,
          redirectUrl: Env.githubAuthUrl,
          title: 'GitHub Connection',
          centerTitle: false,
        );

        final GitHubSignInResult result = await gitHubSignIn.signIn(context);
        switch (result.status) {
          case GitHubSignInResultStatus.ok:
            final String token = result.token ?? "";
            dev.log("token = $token");
            if (token.isEmpty) {
              throw Exception("result.token is empty");
            }
            final AuthCredential credential = GithubAuthProvider.credential(result.token!);
            
            await FirebaseAuth.instance.signInWithCredential(credential);
          
            return true;
          case GitHubSignInResultStatus.cancelled:
          case GitHubSignInResultStatus.failed:
            dev.log("result.errorMessage = ${result.errorMessage}");
            return false;
          }
      
      } catch (e) {
        dev.log('exception->$e');
        return false;
      }

  }

  static Future<bool> userLoggingOut() async {
      try {
        await FirebaseAuth.instance.signOut();
        dev.log('  sign out successfully');
        return true;
      } on Exception catch (_) {
        return false;
      }
  }

}