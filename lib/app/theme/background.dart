import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class Background extends StatelessWidget {
  final Widget body;

  Background({required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              HexColor(GlobalVariables.MAIN_COLOR),
              HexColor(GlobalVariables.SECOND_COLOR),
              HexColor(GlobalVariables.THIRD_COLOR)
            ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          body,
        ],
      ),
    );
  }
}
