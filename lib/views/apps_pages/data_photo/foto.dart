import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koperasi/views/component/theme/color.dart';

class Foto extends StatefulWidget {
  const Foto({
    super.key,
    required this.src,
  });
  final String src;

  @override
  State<Foto> createState() => _FotoState();
}

class _FotoState extends State<Foto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, '');
          },
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: Container(alignment: Alignment.center, child: Image.network(widget.src)),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: black,
                side: BorderSide(width: 3, color: white),
                minimumSize: Size(MediaQuery.of(context).size.width * .48, 50),
              ),
              onPressed: () async {},
              child: const Text(
                'Galery',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: black,
                side: BorderSide(width: 3, color: white),
                minimumSize: Size(MediaQuery.of(context).size.width * .48, 50),
              ),
              onPressed: () async {},
              child: const Text(
                'Camera',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
