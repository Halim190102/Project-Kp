import 'package:flutter/material.dart';
import 'package:koperasi/views/component/theme/color.dart';

class ButtonCom extends StatelessWidget {
  const ButtonCom({
    Key? key,
    required this.text,
    required this.onTap,
    required this.icon,
    required this.color,
  }) : super(key: key);
  final String text;
  final Function()? onTap;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 2),
            child: Text(
              text,
              style: TextStyle(
                color: black,
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),
            ),
          ),
          CircleAvatar(
            radius: 25,
            backgroundColor: color,
            child: IconButton(
              onPressed: onTap,
              icon: Icon(
                icon,
                color: white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
