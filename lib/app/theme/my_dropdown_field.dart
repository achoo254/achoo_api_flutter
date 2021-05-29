import 'package:achoo_api/app/data/model/collection.dart';
import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class MyDropdownField extends StatelessWidget {
  double? width;
  final dynamic objectSeleted;
  final Function(dynamic) onChanged;
  final List<DropdownMenuItem<Object>> itemList;

  MyDropdownField(
      {Key? key,
        this.width, this.objectSeleted,
      required this.itemList,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width != null ? width : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: Container(
          color: HexColor(GlobalVariables.THIRD_COLOR),
          child: DropdownButtonFormField(
            value: objectSeleted,
            isExpanded: true,
            dropdownColor: HexColor(GlobalVariables.THIRD_COLOR),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
            icon: Icon(
              Icons.arrow_drop_down,
              color: GlobalVariables.TEXT_COLOR,
            ),
            items: itemList,
            onChanged: (_newValue) {
              onChanged(_newValue);
            },
          ),
        ),
      ),
    );
  }
}
