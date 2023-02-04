import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final int? maxLines;
  final TextAlign? textAlign;
  final double? letterSpacing;
  const CustomText(
      {Key? key,
      required this.text,
      required this.size,
      required this.color,
      required this.weight,
      this.maxLines = 1,
      this.textAlign = TextAlign.center,
      this.letterSpacing = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
        fontFamily: "Product-Sans",
      ),
    );
  }
}
