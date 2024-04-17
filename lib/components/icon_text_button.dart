import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final IconData icon;
  final Widget child;
  final Function() onPress;

  const IconTextButton(
      {super.key,
      required this.icon,
      required this.child,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          children: [Icon(icon), child, const Spacer()],
        ),
      ),
    );
  }
}
