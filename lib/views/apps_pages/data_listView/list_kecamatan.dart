import 'package:flutter/material.dart';

class ListKecamatan extends StatelessWidget {
  const ListKecamatan({
    Key? key,
    required this.kecamatans,
  }) : super(key: key);

  final String? kecamatans;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Kecamatan ${kecamatans!}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Rob',
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_circle_rounded,
              color: Colors.blueGrey,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
