import 'package:flutter/material.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';

class CategorySelection extends StatelessWidget {
  final String eachCategoryName;
  final List eachCategoryFood;
  const CategorySelection(
      {Key? key,
      required this.eachCategoryFood,
      required this.eachCategoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(eachCategoryName);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTileHeader(context),
          const SizedBox(
            height: 40,
          ),
          buildFoodTileList(context),
        ],
      ),
    );
  }

  Widget buildFoodTileList(BuildContext context) {
    return Column(
      children: List.generate(
        // widget.category.foods.length,
        eachCategoryFood.length,
        (index) {
          final food = eachCategoryFood[index];
          bool isLastIndex = index == eachCategoryFood.length - 1;
          // print(food["image"]);
          return _buildFoodTile(
            food: food,
            context: context,
            isLastIndex: isLastIndex,
          );
        },
      ),
    );
  }

  Widget _buildSectionTileHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        _sectionTitle(context),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          CustomText(
            text: eachCategoryName,
            size: SIZE.titleTextSize,
            color: COLORS.primary,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  // Widget _sectionSubtitle(BuildContext context) {
  Widget _buildFoodTile({
    required BuildContext context,
    required bool isLastIndex,
    required Map food,
  }) {
    return GestureDetector(
      onTap: () {
        // if (food.price.length == 1) {
        //   _addToCart(food);
        // } else {}
      },
      child: Container(
        height: 250,
        // color: COLORS.grey,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildFoodDetail(food: food, context: context),
                  const SizedBox(
                    width: 20,
                  ),
                  _buildFoodImage(food["image"]),
                ],
              ),
              // !isLastIndex
              //     ? const SizedBox(
              //         height: 10,
              //       )
              //     : const SizedBox(height: 5)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoodImage(String url) {
    return url != ""
        ? Container(
            child: Image(
              image: NetworkImage(url),
              width: 124,
              height: 124,
            ),
          )
        : Container(
            width: 124,
            height: 124,
            color: COLORS.heavyGrey,
          );
    // return FadeInImage.assetNetwork(
    //   placeholder: 'assets/transparent.png',
    //   image: url,
    //   width: 64,
    // );
  }

  Widget _buildFoodDetail({
    required BuildContext context,
    required Map food,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 220,
          child: CustomText(
            text: food["name"],
            size: SIZE.textSize,
            color: COLORS.black,
            weight: FontWeight.normal,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        food["description"] != null
            ? Container(
                width: 220,
                child: CustomText(
                  text: food["description"],
                  size: SIZE.subTextSize,
                  color: COLORS.heavyGrey,
                  weight: FontWeight.normal,
                ),
              )
            : SizedBox(),
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Text(
              food["price"].toString() + "\$",

              // style: _textTheme(context).caption,
            ),
            // Text(
            //   food.comparePrice,
            //   style: _textTheme(context)
            //       .caption
            //       ?.copyWith(decoration: TextDecoration.lineThrough),
            // ),
            const SizedBox(width: 30),
            // if (food.isHotSale) _buildFoodHotSaleIcon(),
          ],
        ),
      ],
    );
  }
}
