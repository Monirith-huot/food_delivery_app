import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';
import 'package:heroicons/heroicons.dart';

class SpecialOfferCardWidget extends StatefulWidget {
  final Map<String, dynamic> restaurant;
  final String uuid;
  const SpecialOfferCardWidget(
      {Key? key, required this.restaurant, required this.uuid})
      : super(key: key);

  @override
  _SpecialOfferCardWidgetState createState() => _SpecialOfferCardWidgetState();
}

class _SpecialOfferCardWidgetState extends State<SpecialOfferCardWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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

        return GestureDetector(
          onTap: () {
            if (widget.restaurant["food_categories"] == null &&
                widget.restaurant[" food_categories"] == null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuScreen(
                    foodCategory: widget.restaurant["food_category"],
                    restaurantImage: widget.restaurant["image"],
                    restaurantName: widget.restaurant["name"],
                    discount: widget.restaurant["discount"],
                  ),
                ),
              );
            } else if (widget.restaurant["food_categories"] == null &&
                widget.restaurant["food_category"] == null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuScreen(
                    foodCategory: widget.restaurant[" food_categories"],
                    restaurantImage: widget.restaurant["image"],
                    restaurantName: widget.restaurant["name"],
                    discount: widget.restaurant["discount"],
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuScreen(
                    foodCategory: widget.restaurant["food_categories"],
                    restaurantImage: widget.restaurant["image"],
                    restaurantName: widget.restaurant["name"],
                    discount: widget.restaurant["discount"],
                  ),
                ),
              );
            }
          },
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image(
                      image: NetworkImage(
                        widget.restaurant['image'],
                      ),
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                      height: 75,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: widget.restaurant['name'],
                        size: SIZE.textSize,
                        color: COLORS.black,
                        weight: FontWeight.normal,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const HeroIcon(
                            HeroIcons.star,
                            style: HeroIconStyle.solid,
                            color: COLORS.primary,
                            size: 10,
                          ),
                          CustomText(
                            text: widget.restaurant['rating'],
                            size: SIZE.subTextSize,
                            color: COLORS.heavyGrey,
                            weight: FontWeight.normal,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: widget.restaurant['categories'].join(" "),
                        size: SIZE.subTextSize,
                        color: COLORS.heavyGrey,
                        weight: FontWeight.normal,
                      ),
                      const Spacer(),
                      CustomText(
                        text: "${25 + Random().nextInt(21)} min",
                        size: SIZE.subTextSize,
                        color: COLORS.heavyGrey,
                        weight: FontWeight.normal,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CustomText(
                    text: "Free Delivery fee",
                    size: SIZE.subTextSize,
                    color: COLORS.primary,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              Positioned(
                right: 10,
                top: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    color: Colors.white,
                    width: 20,
                    height: 20,
                    child: GestureDetector(
                      onTap: () {
                        snapshot.data!['favorite']
                                .contains(widget.restaurant['rId'])
                            ? FirebaseFirestore.instance
                                .collection("users")
                                .doc(widget.uuid)
                                .update({
                                "favorite": FieldValue.arrayRemove(
                                    [widget.restaurant['rId']])
                              })
                            : FirebaseFirestore.instance
                                .collection("users")
                                .doc(widget.uuid)
                                .update({
                                "favorite": FieldValue.arrayUnion(
                                    [widget.restaurant['rId']])
                              });
                      },
                      child: Center(
                        child: snapshot.data!['favorite']
                                .contains(widget.restaurant['rId'])
                            ? const HeroIcon(
                                HeroIcons.heart,
                                size: SIZE.smallIconSize,
                                style: HeroIconStyle.solid,
                                color: COLORS.primary,
                              )
                            : const HeroIcon(
                                HeroIcons.heart,
                                size: SIZE.smallIconSize,
                                color: COLORS.primary,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              widget.restaurant['discount'] != "no"
                  ? Positioned(
                      top: 50,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        child: Container(
                          color: COLORS.primary,
                          child: GestureDetector(
                            onTap: () {
                              // context
                              //     .read<FavoriteLogic>()
                              //     .addToFavorite(widget.restaurant);
                            },
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: CustomText(
                                  text: widget.restaurant['discount'] +
                                      " on selected items",
                                  size: SIZE.subTextSize,
                                  color: COLORS.white,
                                  weight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
