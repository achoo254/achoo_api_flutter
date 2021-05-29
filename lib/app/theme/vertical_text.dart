import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VerticalText extends StatelessWidget {
  String title;

  VerticalText(this.title);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
        quarterTurns: -1,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 38,
            fontWeight: FontWeight.w900,
          ),
        ));
  }
}
