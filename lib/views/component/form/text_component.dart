import 'package:flutter/material.dart';

class TextCom extends StatelessWidget {
  const TextCom({
    Key? key,
    required this.onTap,
    required this.text1,
    required this.color,
  }) : super(key: key);
  final String text1;
  final Function() onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 15, top: 20),
      child: InkWell(
        onTap: onTap,
        child: Text(
          text1,
          style: TextStyle(
            color: color,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

// textCom({required String text}) {
//   return Container(
//     margin: const EdgeInsets.only(bottom: 10),
//     child: Text(
//       text,
//       style: const TextStyle(
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   );
// }
