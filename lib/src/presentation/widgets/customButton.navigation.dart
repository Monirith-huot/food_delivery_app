import 'package:flutter/material.dart';
import 'package:food_delivery_app/src/utils/pallete.dart';

class CustomizeButtonNavigation extends StatelessWidget {
  final double? height;
  final double width;
  final Color? bgColor;
  final double? radius;
  final Widget child;
  final VoidCallback navigation;
  final AlignmentGeometry? alignment;
  final bool border;
  const CustomizeButtonNavigation({
    Key? key,
    this.height = SIZE.buttonHeight,
    required this.width,
    this.bgColor = COLORS.primary,
    this.radius = SIZE.radius,
    required this.child,
    this.alignment = Alignment.center,
    this.border = false,
    required this.navigation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigation,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          border: border == true
              ? Border.all(color: COLORS.black.withOpacity(0.5))
              : null,
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
