import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';

import "package:food_delivery_app/src/presentation/views/home/widget/widget.dart";

import 'package:heroicons/heroicons.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: COLORS.white.withOpacity(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Text("Drawer header here"),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    ListTileWidget(
                      title: "Order",
                      icon: HeroIcons.documentText,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderScreen(),
                        ),
                      ),
                    ),
                    ListTileWidget(
                      title: "History",
                      icon: HeroIcons.documentMagnifyingGlass,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistorySreen(),
                        ),
                      ),
                    ),
                    ListTileWidget(
                      title: "Setting",
                      icon: HeroIcons.cog6Tooth,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingScreen(),
                        ),
                      ),
                    ),
                    ListTileWidget(
                      title: "Help Center",
                      icon: HeroIcons.questionMarkCircle,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingScreen(),
                        ),
                      ),
                    ),
                    ListTileWidget(
                      title: "Terms and condition",
                      icon: HeroIcons.documentCheck,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TermConditionScreen(),
                        ),
                      ),
                    ),
                    ListTileWidget(
                      title: "Data and privacy",
                      icon: HeroIcons.documentChartBar,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DataPolityScreen(),
                        ),
                      ),
                    ),
                    ListTileWidget(
                      title: "Profile",
                      icon: HeroIcons.user,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Column(
                    children: <Widget>[
                      Divider(),
                      ListTileWidget(
                        title: "Log out",
                        icon: HeroIcons.arrowLeftOnRectangle,
                        onTap: () => signUserOut(),
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
      ),
    );
  }
}
