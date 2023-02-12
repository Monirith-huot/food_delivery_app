import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';

import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/presentation/views/menu/widget/foodSelection.widget.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:heroicons/heroicons.dart';

class FoodSelectionWidget extends StatefulWidget {
  final Map<dynamic, dynamic> food;
  final String discount;
  const FoodSelectionWidget(
      {Key? key, required this.food, required this.discount})
      : super(key: key);

  @override
  _FoodSelectionWidgetState createState() => _FoodSelectionWidgetState();
}

class _FoodSelectionWidgetState extends State<FoodSelectionWidget> {
  int _counterValue = 1;
  int value = 0;
  TextEditingController recommendation = TextEditingController();
  @override
  Widget build(BuildContext context) {
    try {
      var discountPrice = double.parse(widget.discount.substring(0, 2));
      return Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const HeroIcon(
                        HeroIcons.chevronDown,
                        color: COLORS.primary,
                        size: SIZE.iconsSize,
                      ),
                    ),
                  ),
                  Image.network(
                    widget.food['image'],
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 200,
                              child: CustomText(
                                text: widget.food['name'],
                                size: SIZE.textSize,
                                color: COLORS.primary,
                                weight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            CustomText(
                              text: widget.food["price"].toStringAsFixed(2) +
                                  " \$",
                              size: SIZE.textSize,
                              color: COLORS.heavyGrey,
                              weight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                            const SizedBox(width: 10),
                            CustomText(
                              text: (widget.food["price"] -
                                          (widget.food["price"] *
                                              discountPrice /
                                              100))
                                      .toStringAsFixed(2) +
                                  " \$",
                              size: SIZE.textSize,
                              color: COLORS.primary,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            const CustomText(
                              text: "Choose Your Size",
                              size: SIZE.subTextSize,
                              color: COLORS.black,
                              weight: FontWeight.bold,
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: COLORS.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const CustomText(
                                text: "1 required",
                                size: SIZE.smallTextSize,
                                color: COLORS.white,
                                weight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const CustomText(
                          text: "Selected",
                          size: SIZE.subTextSize,
                          color: COLORS.heavyGrey,
                          weight: FontWeight.bold,
                        ),
                        Container(
                          height: widget.food["customized_food"].length * 50.0,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.food["customized_food"].length,
                            itemBuilder: (ctx, index) {
                              return ListTile(
                                leading: Radio(
                                  value: index,
                                  groupValue: value,
                                  fillColor: MaterialStateColor.resolveWith(
                                    (states) => COLORS.primary,
                                  ), //<-- SEE HERE
                                  onChanged: (ind) => setState(
                                    () {
                                      setState(() {
                                        value = ind as int;
                                      });
                                    },
                                  ),
                                ),
                                title: CustomText(
                                  text: widget.food["customized_food"][index]
                                      ["size"],
                                  size: SIZE.textSize,
                                  color: COLORS.primary,
                                  weight: FontWeight.normal,
                                ),
                                trailing: Wrap(
                                  children: [
                                    CustomText(
                                      text: widget.food["customized_food"]
                                                  [index]['price']
                                              .toStringAsFixed(2) +
                                          " \$",
                                      size: SIZE.textSize,
                                      color: COLORS.heavyGrey,
                                      weight: FontWeight.normal,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                    const SizedBox(width: 10),
                                    CustomText(
                                      text: (widget.food["customized_food"]
                                                      [index]['price'] -
                                                  (widget.food[
                                                              "customized_food"]
                                                          [index]['price'] *
                                                      discountPrice /
                                                      100))
                                              .toStringAsFixed(2) +
                                          " \$",
                                      size: SIZE.textSize,
                                      color: COLORS.primary,
                                      weight: FontWeight.normal,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
                                  borderRadius: BorderRadius.circular(10),
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
          ),
        ),
      );
    } on FormatException {
      return Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const HeroIcon(
                        HeroIcons.chevronDown,
                        color: COLORS.primary,
                        size: SIZE.iconsSize,
                      ),
                    ),
                  ),
                  Image.network(
                    widget.food['image'],
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 200,
                              child: CustomText(
                                text: widget.food['name'],
                                size: SIZE.textSize,
                                color: COLORS.primary,
                                weight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            CustomText(
                              text: widget.food["price"].toString() + " \$",
                              size: SIZE.textSize,
                              color: COLORS.primary,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            const CustomText(
                              text: "Choose Your Size",
                              size: SIZE.subTextSize,
                              color: COLORS.black,
                              weight: FontWeight.bold,
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: COLORS.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const CustomText(
                                text: "1 required",
                                size: SIZE.smallTextSize,
                                color: COLORS.white,
                                weight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const CustomText(
                          text: "Selected",
                          size: SIZE.subTextSize,
                          color: COLORS.heavyGrey,
                          weight: FontWeight.bold,
                        ),
                        Container(
                          height: widget.food["customized_food"].length * 50.0,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.food["customized_food"].length,
                            itemBuilder: (ctx, index) {
                              return ListTile(
                                leading: Radio(
                                  value: index,
                                  groupValue: value,
                                  fillColor: MaterialStateColor.resolveWith(
                                    (states) => COLORS.primary,
                                  ), //<-- SEE HERE
                                  onChanged: (ind) => setState(
                                    () {
                                      setState(() {
                                        value = ind as int;
                                      });
                                    },
                                  ),
                                ),
                                title: CustomText(
                                  text: widget.food["customized_food"][index]
                                      ["size"],
                                  size: SIZE.textSize,
                                  color: COLORS.primary,
                                  weight: FontWeight.normal,
                                ),
                                trailing: (CustomText(
                                  text: widget.food['customized_food'][index]
                                              ['price']
                                          .toStringAsFixed(2) +
                                      " \$",
                                  size: SIZE.textSize,
                                  color: COLORS.primary,
                                  weight: FontWeight.normal,
                                )),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
                                  borderRadius: BorderRadius.circular(10),
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
          ),
        ),
      );
    }
  }
}
