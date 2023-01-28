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
            children: [
              const CustomText(
                text: "Hello this is me",
                size: SIZE.headerTextSize,
                color: COLORS.primary,
                weight: FontWeight.bold,
              ),
              CustomizeButton(
                to: const LoginScreen(title: "hello"),
                width: SIZE.medimunButtonWidth,
                child: Container(
                  child: Text("Hello"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
