import 'package:flutter/material.dart';

import '../../../screens.dart';

class LoginOrSignupScreen extends StatefulWidget {
  const LoginOrSignupScreen({Key? key}) : super(key: key);

  @override
  _LoginOrSignupScreenState createState() => _LoginOrSignupScreenState();
}

class _LoginOrSignupScreenState extends State<LoginOrSignupScreen> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(
        onTap: togglePages,
      );
    } else {
      return SignupScreen(
        onTap: togglePages,
      );
    }
  }
}
