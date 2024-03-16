import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer' as dev;


enum LogState {
  google,
  github,
  unknownProvider,
  notLogged,
}

class UserState extends ChangeNotifier {
  
  UserState() {
    init();
  }

  String _displayName = '';
  String _email = '';
  String _photoURL = '';
  LogState _logstate = LogState.notLogged;

  LogState get logstate => _logstate;
  String get displayName => _displayName;
  String get email => _email;
  String get photoURL => _photoURL;


  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((User? user) { 
      final userCopy = user;
      if (userCopy == null) {
        _clear();
      } else {
        _login(userCopy);
      }
      notifyListeners();
    });
  }


  _clear() {
    _logstate = LogState.notLogged;
    _displayName = '';
    _email = '';
    _photoURL = '';
  }

  _login(User user) {
    _logstate = _getProvider(user);
    _displayName = user.displayName ?? '';
    _email = user.email ?? '';
    _photoURL = user.photoURL ?? '';
    _printUserInfo(user); // [!] DEBUG ONLY

  }

  LogState _getProvider(User user) {
    LogState logstate = LogState.unknownProvider;
    for (var userInfo in user.providerData) {
      if (userInfo.providerId == 'github.com') {
        logstate = LogState.github;
      } else if (userInfo.providerId == 'google.com') {
        logstate = LogState.google;
      }
    }
    return logstate;
  }

  // [!] DEBUG ONLY
  _printUserInfo(User user) {
    for (var userInfo in user.providerData) {
      dev.log("  Provider-specific UID: ${userInfo.uid}");
      dev.log("  Name: ${userInfo.displayName}");
      dev.log("  Email: ${userInfo.email}");
      dev.log("  Photo URL: ${userInfo.photoURL}");
      dev.log("  Sign-in provider: ${userInfo.providerId}");
    }
  }
  
}