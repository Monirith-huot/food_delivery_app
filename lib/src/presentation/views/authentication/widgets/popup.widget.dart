import 'package:flutter/material.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';

class PopupWidget extends StatefulWidget {
  final String errorMessage;
  final String recommedMessage;
  const PopupWidget(
      {Key? key, required this.errorMessage, required this.recommedMessage})
      : super(key: key);

  @override
  _PopupWidgetState createState() => _PopupWidgetState();
}

class _PopupWidgetState extends State<PopupWidget> {
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
          text: widget.errorMessage,
          size: SIZE.textSize,
          color: COLORS.primary,
          weight: FontWeight.bold),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 100,
        child: CustomText(
          textAlign: TextAlign.center,
          text: widget.recommedMessage,
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
            width: SIZE.medimunButtonWidth,
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
