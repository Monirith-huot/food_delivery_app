import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final String title;
  const LoginScreen({Key? key, required this.title}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(widget.title));
  }
}
