import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';

class CustomizeButton extends StatelessWidget {
  final double? height;
  final double width;
  final Color? bgColor;
  final double? radius;
  final Widget child;
  final Widget to;
  final AlignmentGeometry? alignment;
  const CustomizeButton({
    Key? key,
    this.height = SIZE.buttonHeight,
    required this.width,
    this.bgColor = COLORS.primary,
    this.radius = SIZE.radius,
    required this.child,
    this.alignment = Alignment.center,
    required this.to,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => to,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius!),
        ),
        alignment: alignment,
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
