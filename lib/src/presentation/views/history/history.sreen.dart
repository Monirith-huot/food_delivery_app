import 'package:flutter/material.dart';

class HistorySreen extends StatefulWidget {
  const HistorySreen({Key? key}) : super(key: key);

  @override
  _HistorySreenState createState() => _HistorySreenState();
}

class _HistorySreenState extends State<HistorySreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("History"),
      ),
    );
  }
}
