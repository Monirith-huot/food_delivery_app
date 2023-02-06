import 'package:flutter/material.dart';
import "package:food_delivery_app/src/presentation/views/home/widget/widget.dart";

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CategoriesCard(
                title: "Pizza",
                image: "assets/images/pizza.png",
                onTap: () => null,
              ),
              const SizedBox(width: 15),
              CategoriesCard(
                title: "Korea",
                image: "assets/images/korea.png",
                onTap: () => null,
              ),
              const SizedBox(width: 15),
              CategoriesCard(
                title: "Cake",
                image: "assets/images/bakery.png",
                onTap: () => null,
              ),
              const SizedBox(width: 15),
              CategoriesCard(
                title: "Breakfast",
                image: "assets/images/breakfast.png",
                onTap: () => null,
              ),
              const SizedBox(width: 15),
              CategoriesCard(
                title: "Burget",
                image: "assets/images/hamburger.png",
                onTap: () => null,
              ),
              const SizedBox(width: 15),
              CategoriesCard(
                title: "Japanese",
                image: "assets/images/japanese.png",
                onTap: () => null,
              ),
              const SizedBox(width: 15),
              CategoriesCard(
                title: "India",
                image: "assets/images/india.png",
                onTap: () => null,
              ),
              const SizedBox(width: 15),
              CategoriesCard(
                title: "India",
                image: "assets/images/vietnam.png",
                onTap: () => null,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoriesCard(
                title: "Fast Food",
                image: "assets/images/fast_food.png",
                onTap: () => null,
              ),
              const SizedBox(width: 15),
              CategoriesCard(
                title: "Khmer",
                image: "assets/images/khmer.png",
                onTap: () => null,
              ),
              const SizedBox(width: 15),
              CategoriesCard(
                title: "BBQ",
                image: "assets/images/bbq.png",
                onTap: () => null,
              ),
              const SizedBox(width: 15),
              CategoriesCard(
                title: "Beverage",
                image: "assets/images/beverage.png",
                onTap: () => null,
              ),
              const SizedBox(width: 15),
              CategoriesCard(
                title: "Chinese",
                image: "assets/images/chinese.png",
                onTap: () => null,
              ),
              const SizedBox(width: 15),
              CategoriesCard(
                title: "Street Food",
                image: "assets/images/street_food.png",
                onTap: () => null,
              ),
              const SizedBox(width: 15),
              CategoriesCard(
                title: "Dessert",
                image: "assets/images/dessert.png",
                onTap: () => null,
              ),
              const SizedBox(width: 15),
              CategoriesCard(
                title: "Sea Food",
                image: "assets/images/sea_food.png",
                onTap: () => null,
              ),
              const SizedBox(width: 15),
            ],
          ),
        ],
      ),
    );
  }
}
