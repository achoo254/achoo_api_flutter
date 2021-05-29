import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:flutter/material.dart';

class MyTextTitle extends StatelessWidget {
  final String title;
  final TextStyle? textStyle;
  final TextOverflow textOverflow;
  final double? customSize;

  MyTextTitle({Key? key, required this.title, this.textStyle, this.textOverflow = TextOverflow.visible, this.customSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        overflow: textOverflow,
        style: textStyle == null ? TextStyle(
            color: GlobalVariables.LABEL_COLOR,
            fontWeight: FontWeight.bold,
            fontSize: customSize == null ? GlobalVariables.LABEL_FIELD_SIZE : customSize) : textStyle,
      ),
    );
  }
}
