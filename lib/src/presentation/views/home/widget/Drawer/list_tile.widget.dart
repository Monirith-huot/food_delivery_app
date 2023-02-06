import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';

class ListTileWidget extends StatelessWidget {
  final String title;
  final HeroIcons icon;
  final VoidCallback onTap;
  const ListTileWidget(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomText(
        text: title,
        size: SIZE.textSize,
        color: COLORS.black,
        weight: FontWeight.normal,
        textAlign: TextAlign.left,
      ),
      leading: HeroIcon(
        icon,
        color: COLORS.primary,
      ),
      onTap: onTap,
    );
  }
}
