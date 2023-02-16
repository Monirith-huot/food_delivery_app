import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/widget/widget.dart';

class FavoriteScreen extends StatefulWidget {
  final String uuid;
  const FavoriteScreen({Key? key, required this.uuid}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uuid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon:
                  const HeroIcon(HeroIcons.chevronLeft, color: COLORS.primary),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: COLORS.white,
            title: const CustomText(
              text: "Favorite",
              size: SIZE.titleTextSize,
              color: COLORS.primary,
              weight: FontWeight.normal,
            ),
            actions: [
              GestureDetector(
                child: const HeroIcon(
                  HeroIcons.trash,
                  color: COLORS.primary,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertAction(
                        title: "Remove all favorites !! ",
                        description:
                            "This action will remove all your favorite restaurants",
                        otherPop: false,
                        onTap: () async {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(widget.uuid)
                              .update(
                            {
                              "favorite": [],
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(30),
            child: snapshot.data!['favorite'].length > 0
                ? ListView.builder(
                    itemCount: snapshot.data!['favorite'].length,
                    itemBuilder: (ctx, index) {
                      return StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("restaurant ")
                            .doc(snapshot.data!['favorite'][index].trim())
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading");
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: SpecialOfferCardWidget(
                                uuid: widget.uuid,
                                restaurant: snapshot.data!.data()
                                    as Map<String, dynamic>),
                          );
                        },
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/bookmark.png",
                          width: 100,
                          height: 100,
                        ),
                        const CustomText(
                          text: "You dont have any favorite restaurants yet !!",
                          size: SIZE.subTextSize,
                          color: COLORS.primary,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
