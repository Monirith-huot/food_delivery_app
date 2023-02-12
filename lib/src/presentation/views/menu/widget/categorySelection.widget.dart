import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/presentation/views/menu/widget/foodSelection.widget.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:page_transition/page_transition.dart';

class CategorySelectionWidget extends StatefulWidget {
  final String discount;
  final String eachCategoryName;
  final List eachCategoryFood;

  const CategorySelectionWidget({
    Key? key,
    required this.eachCategoryFood,
    required this.eachCategoryName,
    required this.discount,
  }) : super(key: key);

  @override
  State<CategorySelectionWidget> createState() =>
      _CategorySelectionWidgetState();
}

class _CategorySelectionWidgetState extends State<CategorySelectionWidget> {
  TextEditingController recommendation = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        widget.eachCategoryFood.length,
        (index) {
          final food = widget.eachCategoryFood[index];
          bool isLastIndex = index == widget.eachCategoryFood.length - 1;
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
            text: widget.eachCategoryName.trim(),
            size: SIZE.titleTextSize,
            color: COLORS.primary,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget _buildFoodTile({
    required BuildContext context,
    required bool isLastIndex,
    required Map food,
  }) {
    return Container(
      height: 250,
      // color: COLORS.grey,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: GestureDetector(
          onTap: () {
            if (food["customized_food"].length == 0) {
              // _addToCart(
              //     context: context, food: food);
              if (widget.eachCategoryName == "Promotion Items") {
                _addToCart(
                    context: context, food: food, discount: widget.discount);
              } else {
                _addToCart(context: context, food: food, discount: "No");
              }
            } else {
              if (widget.eachCategoryName == "Promotion Items") {
                Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.linear,
                    type: PageTransitionType.bottomToTop,
                    child: FoodSelectionWidget(
                        food: food, discount: widget.discount),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.linear,
                    type: PageTransitionType.bottomToTop,
                    child: FoodSelectionWidget(
                      food: food,
                      discount: "No",
                    ),
                  ),
                );
              }
            }
          },
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
  }

  Widget _buildFoodDetail({
    required BuildContext context,
    required Map food,
  }) {
    var price = double.parse(food['price'].toString());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 220,
          child: CustomText(
            text: food["name"].trim(),
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
                  text: food["description"].trim(),
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
            widget.eachCategoryName == "Promotion Items"
                ? Row(
                    children: [
                      Text(
                        food["price"].toString() + " \$",
                        style: const TextStyle(
                          color: COLORS.heavyGrey,
                          fontSize: SIZE.subTextSize,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                          fontFamily: "Product-Sans",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${(price - (price * int.parse(widget.discount.substring(0, 2)) / 100)).toStringAsFixed(2)} \$",
                        style: const TextStyle(
                          color: COLORS.primary,
                          fontSize: SIZE.subTextSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Product-Sans",
                        ),
                      ),
                    ],
                  )
                : Text(
                    "${food["price"]} \$",
                    style: const TextStyle(
                      color: COLORS.primary,
                      fontSize: SIZE.subTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ],
        )
      ],
    );
  }

  _addToCart(
      {required BuildContext context, required food, required discount}) {
    int _counterValue = 1;

    try {
      var value = double.parse(discount.substring(0, 2));
      return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: DraggableScrollableSheet(
              initialChildSize: 0.5,
              maxChildSize: 0.9,
              minChildSize: 0.2,
              expand: false,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  controller: scrollController,
                  child: StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            child: Image(
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(
                                food['image'],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      text: food['name'],
                                      size: SIZE.textSize,
                                      color: COLORS.primary,
                                      weight: FontWeight.bold,
                                    ),
                                    const Spacer(),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          food["price"].toString() + " \$",
                                          style: const TextStyle(
                                            color: COLORS.heavyGrey,
                                            fontSize: SIZE.subTextSize,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "${(food["price"] - (food["price"] * int.parse(widget.discount.substring(0, 2)) / 100)).toStringAsFixed(2)} \$",
                                          style: const TextStyle(
                                            color: COLORS.primary,
                                            fontSize: SIZE.subTextSize,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Product-Sans",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomText(
                                  text: food['description'].trim(),
                                  size: SIZE.subTextSize,
                                  color: COLORS.heavyGrey,
                                  weight: FontWeight.bold,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                const CustomText(
                                  text: "Special Instruction",
                                  size: SIZE.textSize,
                                  color: COLORS.black,
                                  weight: FontWeight.bold,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const CustomText(
                                  text:
                                      "Please let us know if you are allergic to anything or you want us to avoid something",
                                  size: SIZE.subTextSize,
                                  color: COLORS.heavyGrey,
                                  weight: FontWeight.normal,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  controller: recommendation,
                                  keyboardType: TextInputType.multiline,
                                  style: TextStyle(fontSize: 10),
                                  maxLines: 4,
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(
                                      color: COLORS.grey,
                                      fontSize: SIZE.subTextSize,
                                    ),
                                    hintText: "e.g no pineapple",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: COLORS.heavyGrey,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  children: [
                                    Container(
                                      height: SIZE.buttonHeight,
                                      color: COLORS.primary,
                                      child: CounterButton(
                                        countColor: COLORS.white,
                                        loading: false,
                                        onChange: (int val) {
                                          setState(
                                            () {
                                              if (val == 0) {
                                                Navigator.of(context).pop();
                                              } else {
                                                _counterValue = val;
                                              }
                                            },
                                          );
                                        },
                                        count: _counterValue,
                                        buttonColor: COLORS.white,
                                        progressColor: COLORS.white,
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        print(_counterValue);
                                      },
                                      child: Container(
                                        height: SIZE.buttonHeight,
                                        width: SIZE.smallButtonWidth,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: COLORS.primary,
                                        ),
                                        child: const Center(
                                          child: CustomText(
                                            text: "Add to cart",
                                            size: SIZE.subTextSize,
                                            color: COLORS.white,
                                            weight: FontWeight.normal,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      );
    } on FormatException {
      return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: DraggableScrollableSheet(
              initialChildSize: 0.6,
              maxChildSize: 0.9,
              minChildSize: 0.4,
              expand: false,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: scrollController,
                  child: StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return SizedBox(
                        child: Container(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                                child: Image(
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.fitWidth,
                                  image: NetworkImage(
                                    food['image'],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CustomText(
                                          text: food['name'],
                                          size: SIZE.textSize,
                                          color: COLORS.primary,
                                          weight: FontWeight.bold,
                                        ),
                                        const Spacer(),
                                        CustomText(
                                          text:
                                              food['price'].toString() + " \$",
                                          size: SIZE.subTextSize,
                                          color: COLORS.primary,
                                          weight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomText(
                                      text: food['description'].trim(),
                                      size: SIZE.subTextSize,
                                      color: COLORS.heavyGrey,
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    const CustomText(
                                      text: "Special Instruction",
                                      size: SIZE.textSize,
                                      color: COLORS.black,
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const CustomText(
                                      text:
                                          "Please let us know if you are allergic to anything or you want us to avoid something",
                                      size: SIZE.subTextSize,
                                      color: COLORS.heavyGrey,
                                      weight: FontWeight.normal,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextField(
                                      controller: recommendation,
                                      keyboardType: TextInputType.multiline,
                                      style: TextStyle(fontSize: 10),
                                      maxLines: 4,
                                      decoration: const InputDecoration(
                                        hintStyle: TextStyle(
                                          color: COLORS.grey,
                                          fontSize: SIZE.subTextSize,
                                        ),
                                        hintText: "e.g no pineapple",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: COLORS.heavyGrey,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    Row(
                                      children: [
                                        Container(
                                          height: SIZE.buttonHeight,
                                          color: COLORS.primary,
                                          child: CounterButton(
                                            countColor: COLORS.white,
                                            loading: false,
                                            onChange: (int val) {
                                              setState(
                                                () {
                                                  if (val == 0) {
                                                    Navigator.of(context).pop();
                                                  } else {
                                                    _counterValue = val;
                                                  }
                                                },
                                              );
                                            },
                                            count: _counterValue,
                                            buttonColor: COLORS.white,
                                            progressColor: COLORS.white,
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            print(_counterValue);
                                          },
                                          child: Container(
                                            height: SIZE.buttonHeight,
                                            width: SIZE.smallButtonWidth,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: COLORS.primary,
                                            ),
                                            child: const Center(
                                              child: CustomText(
                                                text: "Add to cart",
                                                size: SIZE.subTextSize,
                                                color: COLORS.white,
                                                weight: FontWeight.normal,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      );
    }
  }
}
