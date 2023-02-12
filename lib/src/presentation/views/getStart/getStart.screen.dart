import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/presentation/customize.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';
import 'package:food_delivery_app/src/presentation/screens.dart';

class GetStartScreen extends StatefulWidget {
  const GetStartScreen({Key? key}) : super(key: key);

  @override
  _GetStartScreenState createState() => _GetStartScreenState();
}

class _GetStartScreenState extends State<GetStartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/take_away.png",
                width: 370,
                height: 350,
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Fastest ",
                      style: TextStyle(
                        fontSize: SIZE.headerTextSize,
                        fontFamily: "Product-Sans",
                        fontWeight: FontWeight.bold,
                        color: COLORS.black,
                      ),
                    ),
                    TextSpan(
                      text: 'Food',
                      style: TextStyle(
                        fontSize: SIZE.headerTextSize,
                        fontFamily: "Product-Sans",
                        fontWeight: FontWeight.bold,
                        color: COLORS.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Delivery ",
                      style: TextStyle(
                        fontSize: SIZE.headerTextSize,
                        fontFamily: "Product-Sans",
                        fontWeight: FontWeight.bold,
                        color: COLORS.primary,
                      ),
                    ),
                    TextSpan(
                      text: 'in Phnom Penh',
                      style: TextStyle(
                        fontSize: SIZE.headerTextSize,
                        fontFamily: "Product-Sans",
                        fontWeight: FontWeight.bold,
                        color: COLORS.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomText(
                text:
                    "Order your favourite food right now. \n  We are ready to delivery in anytime.",
                size: SIZE.textSize,
                color: COLORS.black.withOpacity(0.5),
                weight: FontWeight.normal,
              ),
              const SizedBox(
                height: 60,
              ),
              CustomizeButtonNavigation(
                width: SIZE.medimunButtonWidth,
                navigation: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => AuthScreen(),
                  ),
                ),
                child: CustomText(
                  text: "Get Started",
                  size: SIZE.textSize,
                  color: COLORS.white,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
