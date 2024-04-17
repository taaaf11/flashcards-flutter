// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final Widget icon;
  final Widget child;
  final double? spacing;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final MainAxisAlignment alignment;
  final Color? hoverColor;
  final Color? splashColor;
  final Function() onPress;

  const IconTextButton(
      {super.key,
      required this.icon,
      required this.child,
      this.spacing,
      this.padding,
      this.margin,
      this.borderRadius,
      this.alignment = MainAxisAlignment.start,
      this.hoverColor,
      this.splashColor,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius,
      hoverColor: hoverColor,
      splashColor: splashColor,
      onTap: onPress,
      child: Container(
        padding: padding,
        margin: margin,
        child: Row(
          mainAxisAlignment: alignment,
          children: [icon, SizedBox(width: spacing), child],
        ),
      ),
    );
  }
}
