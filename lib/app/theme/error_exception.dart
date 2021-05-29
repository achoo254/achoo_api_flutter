import 'package:achoo_api/app/theme/my_text_title.dart';
import 'package:flutter/material.dart';

class ErrorException extends StatelessWidget {
  final String error;

  const ErrorException({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextTitle(title: error),
        ],
      )),
    );
  }
}
