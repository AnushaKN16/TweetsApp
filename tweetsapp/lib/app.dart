import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tweetsapp/core/local_db/shared_preferences.dart';
import 'package:tweetsapp/features/onboarding/ui/onboarding_acreen.dart';
import 'package:tweetsapp/features/tweet/ui/tweets_page.dart';

class RegisterOrLogin extends StatefulWidget {
  static StreamController<String> authStream = StreamController.broadcast();
  const RegisterOrLogin({super.key});

  @override
  State<RegisterOrLogin> createState() => _RegisterOrLoginState();
}

class _RegisterOrLoginState extends State<RegisterOrLogin> {
  @override
  void initState() {
    super.initState();
    getUid();
  }

  getUid() async {
    String uid = await SharedPreferencesManager.getUid();

    if (uid.isEmpty) {
      RegisterOrLogin.authStream.add("");
    } else {
      RegisterOrLogin.authStream.add(uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: RegisterOrLogin.authStream.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const OnboardingScreen();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          return const TweetsScreen();
        }
      },
    );
  }
}
