import 'package:flutter/material.dart';

import 'package:vertical_scrollable_tabview/vertical_scrollable_tabview.dart';

class MenuScreen extends StatefulWidget {
  final List foodCategory;
  const MenuScreen({Key? key, required this.foodCategory}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar());
  }
}
