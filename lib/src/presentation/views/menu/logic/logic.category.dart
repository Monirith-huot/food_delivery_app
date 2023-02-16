import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/presentation/views/menu/widget/foodSelection.widget.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';

class LogicForOrder {
  createPopUpDialogForDiffrentRestaurant(
      {required BuildContext context,
      required Map food,
      required int quality,
      required String recommendation,
      required String userId,
      required String restaurantId}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertAction(
          title: "Warning",
          description:
              "You have already ordered from another restaurant. Do you want to clear your cart and order from this restaurant?",
          otherPop: true,
          onTap: () async {
            await FirebaseFirestore.instance
                .collection("users")
                .doc(userId)
                .update(
              {
                "order": [],
              },
            );
            await FirebaseFirestore.instance
                .collection("users")
                .doc(userId)
                .update(
              {
                "order": FieldValue.arrayUnion(
                  [
                    {
                      "rId": restaurantId,
                      "orderFood": [
                        {
                          "food": food,
                          "quantity": quality,
                          "totalPrice": quality * food['price'],
                          "suggestion": recommendation,
                        }
                      ],
                    },
                  ],
                ),
              },
            );
          },
        );
      },
    );
  }

}
