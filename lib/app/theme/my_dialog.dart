import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class MyDialog {
  late final Widget widget;
  final DialogType dialogType;
  final Function() submit;
  final Function() cancel;

  MyDialog({required this.widget, required this.dialogType, required this.submit, required this.cancel});

  show(BuildContext context){
    AwesomeDialog(
      animType: AnimType.SCALE,
      dialogType: dialogType,
      dialogBackgroundColor: HexColor(GlobalVariables.SECOND_COLOR),
      body: widget,
      btnCancelOnPress: () {
        cancel();
      },
      btnOkOnPress: () {
        submit();
      },
      context: context,
    )..show();
  }
}
