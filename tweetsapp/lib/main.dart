import 'package:flutter/material.dart';
import 'package:tweetsapp/design/app_theme.dart';
import 'package:tweetsapp/features/onboarding/ui/onboarding_acreen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      home: const OnboardingScreen(),
    );
  }
}
