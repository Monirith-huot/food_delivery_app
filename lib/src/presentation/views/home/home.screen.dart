import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';
import 'package:heroicons/heroicons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  bool _showDrawer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _showDrawer = false;
              });
            },
            child: Container(
              width: double.infinity,
              color: COLORS.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showDrawer = true;
                                });
                              },
                              child: const HeroIcon(
                                HeroIcons.bars3CenterLeft,
                                style: HeroIconStyle.outline,
                                color: COLORS.white,
                                size: SIZE.iconsSize,
                              ),
                            ),
                          ],
                        ),
                        CustomText(
                          text: "Find your",
                          size: 24,
                          color: COLORS.white,
                          weight: FontWeight.bold,
                        ),
                        CustomText(
                          text: "Favourite food 🫕",
                          size: 24,
                          color: COLORS.white,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Text("Menu here"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _showDrawer
              ? Drawer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: COLORS.white.withOpacity(0.1),
                    ),
                    child: Column(
                      children: <Widget>[
                        DrawerHeader(
                          child: Text("Drawer header here"),
                        ),
                        Expanded(
                          child: Column(children: <Widget>[
                            ListTile(
                              title: const CustomText(
                                text: "Profile",
                                size: SIZE.textSize,
                                color: COLORS.primary,
                                weight: FontWeight.normal,
                                textAlign: TextAlign.left,
                              ),
                              leading: const HeroIcon(
                                HeroIcons.user,
                                color: COLORS.primary,
                              ),
                              onTap: () {
                                /* Navigator.pop(context);
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => dealerBuilder()));*/
                              },
                            ),
                            ListTile(
                              title: Text(
                                'Shuffler',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                              leading: Icon(
                                Icons.shuffle,
                                size: 20.0,
                                color: Colors.white,
                              ),
                              onTap: () {
                                /*Navigator.pop(context);
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => shufflerBuilder()));*/
                              },
                            ),
                            ListTile(
                              title: Text(
                                'Mistakes',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                              leading: Icon(
                                Icons.info_outline,
                                size: 20.0,
                                color: Colors.white,
                              ),
                              onTap: () {
                                /* Navigator.pop(context);
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => mistakePage()));*/
                              },
                            ),
                            ListTile(
                              title: Text(
                                'Important links',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                              leading: Icon(
                                Icons.border_color,
                                size: 20.0,
                                color: Colors.white,
                              ),
                              onTap: () {
                                /*Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => importantLinks()));*/
                              },
                            ),
                          ]),
                        ),
                        Container(
                          child: Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Column(
                              children: <Widget>[
                                Divider(),
                                ListTile(
                                    leading: Icon(Icons.settings),
                                    title: Text('Facebook')),
                                ListTile(
                                  leading: Icon(Icons.help),
                                  title: Text('Instagram'),
                                  onTap: () {
                                    signUserOut();
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
