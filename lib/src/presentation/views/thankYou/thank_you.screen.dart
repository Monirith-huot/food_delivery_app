import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';

class ThankYouScreen extends StatefulWidget {
  final String userId;
  const ThankYouScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ThankYouScreenState createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  bool isloading = false;

  @override
  void initState() {
    FirebaseFirestore.instance.collection("users").doc(widget.userId).update({
      "order": [],
    }).then((value) {
      setState(() {
        isloading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(isloading);
    return Scaffold(
      body: isloading == true
          ? Center(
              child: LoadingAnimationWidget.beat(
                color: COLORS.primary,
                size: 40,
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomText(
                    text: "Thank you for your order",
                    size: SIZE.titleTextSize,
                    color: COLORS.primary,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomText(
                    text: "Your order will be delivered as soon as possible",
                    size: SIZE.textSize,
                    color: COLORS.black,
                    weight: FontWeight.normal,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Image.asset("assets/images/delivery.png"),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: SIZE.buttonHeight,
                    width: SIZE.bigButtonWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: COLORS.primary,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                      child: Center(
                        child: CustomText(
                          text: "Back to homepage",
                          size: SIZE.textSize,
                          color: COLORS.white,
                          weight: FontWeight.normal,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
