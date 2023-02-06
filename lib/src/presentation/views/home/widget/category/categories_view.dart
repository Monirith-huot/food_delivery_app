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
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
      ),
      children: [
        Text("Hello world!"),
      ],
    );
  }
}
