import 'package:flutter/material.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';
import "package:food_delivery_app/src/presentation/views/home/widget/widget.dart";

class FoodCategoryWidget extends StatefulWidget {
  const FoodCategoryWidget({Key? key}) : super(key: key);

  @override
  _FoodCategoryWidgetState createState() => _FoodCategoryWidgetState();
}

class _FoodCategoryWidgetState extends State<FoodCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: "Categories",
          size: SIZE.textSize,
          color: COLORS.black,
          weight: FontWeight.bold,
        ),
        // CategoriesView(),
      ],
    );
  }
}
