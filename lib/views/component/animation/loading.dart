import 'package:flutter/material.dart';
import 'package:koperasi/views/component/theme/color.dart';

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: red,
      ),
    );
  }
}

class Load extends StatelessWidget {
  const Load({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
