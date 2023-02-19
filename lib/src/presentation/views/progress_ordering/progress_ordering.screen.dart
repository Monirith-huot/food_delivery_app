import 'package:flutter/material.dart';

class ProgressOrderingScreen extends StatefulWidget {
  final String userId;
  const ProgressOrderingScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  _ProgressOrderingScreenState createState() => _ProgressOrderingScreenState();
}

class _ProgressOrderingScreenState extends State<ProgressOrderingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //1
      body: CustomScrollView(
        slivers: <Widget>[
          //2
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Goa', textScaleFactor: 1),
              background: Image.network(
                'https://images.unsplash.com/photo-1676799911060-72c098f7ad3d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1335&q=80',
                fit: BoxFit.fill,
              ),
            ),
          ),
          //3
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return ListTile(
                  leading: Container(
                      padding: EdgeInsets.all(8),
                      width: 100,
                      child: Placeholder()),
                  title: Text('Place ${index + 1}', textScaleFactor: 2),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
