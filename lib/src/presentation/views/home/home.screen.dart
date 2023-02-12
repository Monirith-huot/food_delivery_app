import 'package:cloud_firestore/cloud_firestore.dart';
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
  String uuid = "";
  bool _showDrawer = false;

  @override
  void initState() {
    _getDataFromSharedPreferences();
    super.initState();
  }

  void _getDataFromSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      uuid = preferences.getString('uuid')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("restaurant ").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return Scaffold(
          body: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  _showDrawer == true
                      ? setState(() {
                          _showDrawer = false;
                        })
                      : null;
                },
                child: Container(
                  width: double.infinity,
                  color: COLORS.primary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30),
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
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FavoriteScreen(uuid: uuid),
                                          ),
                                        );
                                      },
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
                              //create Navigator push to search screen
                              navigation: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SearchScreen(),
                                ),
                              ),
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
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 10, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FoodCategoryWidget(),
                                const SizedBox(
                                  height: 10,
                                ),

                                //Spcial offer
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        const CustomText(
                                          text: "Special Offers",
                                          size: SIZE.textSize,
                                          color: COLORS.black,
                                          weight: FontWeight.bold,
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          onPressed: () {},
                                          child: const CustomText(
                                            text: "show all",
                                            color: COLORS.primary,
                                            weight: FontWeight.bold,
                                            size: SIZE.subTextSize,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 150,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: snapshot.data!.docs
                                            .where((DocumentSnapshot
                                                    document) =>
                                                (document.data() as Map<String,
                                                    dynamic>)?["discount"] !=
                                                "no")
                                            .map((DocumentSnapshot document) {
                                          Map<String, dynamic> data = document
                                              .data() as Map<String, dynamic>;

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 50),
                                            child: Container(
                                              height: 150,
                                              width: SIZE.cardWidth,
                                              child: SpecialOfferCardWidget(
                                                uuid: uuid,
                                                restaurant: data,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),

                                //Popular resurants
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        const CustomText(
                                          text: "Popular restaurants",
                                          size: SIZE.textSize,
                                          color: COLORS.black,
                                          weight: FontWeight.bold,
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          onPressed: () {},
                                          child: const CustomText(
                                            text: "show all",
                                            color: COLORS.primary,
                                            weight: FontWeight.bold,
                                            size: SIZE.subTextSize,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 150,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: snapshot.data!.docs
                                            .map((DocumentSnapshot document) {
                                          Map<String, dynamic> data = document
                                              .data()! as Map<String, dynamic>;

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              right: 50,
                                            ),
                                            child: Container(
                                              height: 150,
                                              width: SIZE.cardWidth,
                                              child: SpecialOfferCardWidget(
                                                uuid: uuid,
                                                restaurant: data,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
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
      },
    );
  }
}
