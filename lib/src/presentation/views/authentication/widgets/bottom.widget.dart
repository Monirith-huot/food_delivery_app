import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';

class BottomWidget extends StatefulWidget {
  final Widget to;
  final String captionText;
  final String navigationCaption;
  const BottomWidget(
      {Key? key,
      required this.to,
      required this.captionText,
      required this.navigationCaption})
      : super(key: key);

  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: widget.captionText,
              style: const TextStyle(
                fontSize: SIZE.subTextSize,
                fontFamily: "Product-Sans",
                fontWeight: FontWeight.normal,
                color: COLORS.black,
              ),
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => widget.to,
                    ),
                  );
                },
              text: widget.navigationCaption,
              style: const TextStyle(
                fontSize: SIZE.subTextSize,
                fontFamily: "Product-Sans",
                fontWeight: FontWeight.bold,
                color: COLORS.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
