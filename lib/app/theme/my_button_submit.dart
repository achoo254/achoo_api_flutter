import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyButtonSubmit extends StatelessWidget {
  final String title;
  final Function() function;

  MyButtonSubmit({Key? key, required this.function, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: HexColor(GlobalVariables.UTILS_COLOR),
          side: BorderSide(width: 1, color: Colors.transparent),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        onPressed: () {
          function();
        },
        child: Text(title),
      )
    );
  }
}
