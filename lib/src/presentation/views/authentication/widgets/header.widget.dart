import 'package:flutter/material.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final String caption;
  const HeaderWidget({Key? key, required this.title, required this.caption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CustomText(
            text: title,
            size: SIZE.titleTextSize,
            color: COLORS.black,
            weight: FontWeight.bold,
          ),
          CustomText(
            text: caption,
            size: SIZE.textSize,
            color: COLORS.grey,
            weight: FontWeight.normal,
          ),
        ],
      ),
    );
  }
}
