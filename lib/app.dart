import 'package:flutter/material.dart';
import 'package:login_design2/features/authentication/Login/login_page.dart';
import 'package:login_design2/features/authentication/onboarding/onb.dart';
import 'package:login_design2/features/authentication/onboarding/onboarding_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Design',
      initialRoute: '/onboarding',
      routes: {
        '/login': (context) => LoginPage(),
        '/onboarding': (context) => OnboardingPage(),
        '/onb': (context) => Onb(),
      },
    );
  }
}
