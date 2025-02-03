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
    // TODO: implement initState
  }

  getUid() async {
    String uid = SharedPreferencesManager.getUid();

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
        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const OnboardingScreen();
        } else {
          return const TweetsScreen();
        }
      },
    );
  }
}
