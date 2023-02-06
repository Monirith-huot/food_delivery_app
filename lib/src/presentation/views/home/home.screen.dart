import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';

import "package:food_delivery_app/src/presentation/views/home/widget/widget.dart";
import 'package:heroicons/heroicons.dart';

import 'package:food_delivery_app/src/controllers/controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? uuid = "";
  bool _showDrawer = false;

  @override
  void initState() {
    _getDataFromSharedPreferences();
    super.initState();
  }

  void _getDataFromSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      uuid = preferences.getString('uuid');
      print("share" + uuid!);
    });
  }

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
                            const Spacer(),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: const HeroIcon(
                                    HeroIcons.shoppingBag,
                                    color: COLORS.white,
                                  ),
                                ),
                                const SizedBox(width: 30),
                                GestureDetector(
                                  onTap: () {},
                                  child: const HeroIcon(
                                    HeroIcons.heart,
                                    color: COLORS.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const CustomText(
                          text: "Find your",
                          size: 24,
                          color: COLORS.white,
                          weight: FontWeight.bold,
                        ),
                        const CustomText(
                          text: "Favourite food 🫕",
                          size: 24,
                          color: COLORS.white,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(height: 30),
                        CustomizeButtonNavigation(
                          bgColor: COLORS.white,
                          width: SIZE.bigButtonWidth,
                          to: const SearchScreen(),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Row(
                              children: const [
                                HeroIcon(
                                  HeroIcons.magnifyingGlass,
                                  color: COLORS.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CustomText(
                                  text:
                                      "Search for your favorite restaurants here",
                                  size: SIZE.textSize,
                                  color: COLORS.grey,
                                  weight: FontWeight.normal,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 30, right: 30, top: 20, bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FoodCategoryWidget(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _showDrawer ? DrawerWidget() : Container(),
        ],
      ),
    );
  }
}
