import 'package:flutter/material.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';

class CategoriesCard extends StatefulWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const CategoriesCard(
      {Key? key, required this.title, required this.image, required this.onTap})
      : super(key: key);

  @override
  _CategoriesCardState createState() => _CategoriesCardState();
}

class _CategoriesCardState extends State<CategoriesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: SIZE.buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: COLORS.grey.withOpacity(0.25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            // Text(widget.title),
            CustomText(
              text: widget.title,
              size: SIZE.subTextSize,
              color: COLORS.black,
              weight: FontWeight.normal,
            ),
            const Spacer(),
            Image.asset(
              widget.image,
              width: 30,
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
