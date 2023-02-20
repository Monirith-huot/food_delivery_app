import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(widget.userId)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          List ordering = [];
          if (snapshot.hasData) {
            Map<String, dynamic>? data =
                snapshot.data?.data() as Map<String, dynamic>?;
            ordering = data?['ordering'];
          }
          print(ordering[0]['status']);
          return CustomScrollView(
            slivers: <Widget>[
              //2
              SliverAppBar(
                // floating: false,
                pinned: true,
                // snap: false,
                expandedHeight: 150.0,
                flexibleSpace: FlexibleSpaceBar(
                            title: Text('Goa', textScaleFactor: 1),
                            background: ordering[0]['status'] == "ORDERING"
                                ? Image.asset(
                                    'assets/images/waiting_driver.png',
                                    fit: BoxFit.fill,
                                  )
                                : ordering[0]['status']) ==
                        "COOKING"
                    ? Image.asset(
                        'assets/images/cooking.png',
                        fit: BoxFit.fill,
                      )
                    : ordering[0]['status'] == "DELIVERY"
                        ? Image.asset(
                            'assets/images/delivering_to.png',
                            fit: BoxFit.fill,
                          )
                        : ordering[0]['status'] == "FINISH"
                            ? Image.asset(
                                'assets/images/delivered.png',
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                'assets/images/waiting_driver.png',
                                fit: BoxFit.fill,
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
          );
        },
      ),
    );
  }
}
