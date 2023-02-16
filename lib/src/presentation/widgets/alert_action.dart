import 'package:flutter/material.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';

class AlertAction extends StatelessWidget {
  final String title;
  final String description;
  final Function onTap;
  final bool otherPop;

  const AlertAction({
    Key? key,
    required this.title,
    required this.description,
    required this.onTap,
    required this.otherPop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: COLORS.white,
      insetPadding: EdgeInsets.zero,
      alignment: Alignment.center,
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: CustomText(
          text: title,
          size: SIZE.textSize,
          color: COLORS.primary,
          weight: FontWeight.bold),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 100,
        child: CustomText(
          textAlign: TextAlign.center,
          text: description,
          size: SIZE.subTextSize,
          color: COLORS.black,
          weight: FontWeight.normal,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            alignment: Alignment.center,
            width: SIZE.smallButtonWidth,
            height: SIZE.buttonHeight,
            decoration: BoxDecoration(
              color: COLORS.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: COLORS.primary),
            ),
            child: const CustomText(
              text: "Cancel",
              size: SIZE.textSize,
              color: COLORS.primary,
              weight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            onTap();
            if (otherPop) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Container(
            alignment: Alignment.center,
            width: SIZE.smallButtonWidth,
            height: SIZE.buttonHeight,
            decoration: BoxDecoration(
              color: COLORS.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const CustomText(
              text: "Okay",
              size: SIZE.textSize,
              color: COLORS.white,
              weight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
