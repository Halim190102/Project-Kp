import 'package:flutter/material.dart';

class ButtonServices extends StatelessWidget {
  const ButtonServices({
    Key? key,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final Color color;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        size: 16,
        color: color,
      ),
    );
  }
}
