import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:achoo_api/app/utils/validator_variables.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hexcolor/hexcolor.dart';

class MyInputField extends StatelessWidget {
  final int? multiLine;
  final bool? validateRequire;
  final bool? validateEmail;
  final bool? validateMinLength;
  final bool? validateMaxLength;
  final bool? typePassword;
  final String? hintText;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  MyInputField(
      {Key? key,
      this.multiLine,
      this.validateRequire,
      this.validateEmail,
      this.validateMinLength,
      this.validateMaxLength,
      this.typePassword,
      this.hintText,
      this.inputType,
      this.controller,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FieldValidator> validators = [];
    if (validateRequire == true) {
      validators
          .add(RequiredValidator(errorText: ValidatorVariables.REQUIRE_VALUE));
    }
    if (validateMinLength == true) {
      validators.add(MinLengthValidator(
          ValidatorVariables.TEXT_INPUT_MIN_LENGTH,
          errorText: ValidatorVariables.REQUIRE_MIN_VALUE));
    }
    if (validateMaxLength == true) {
      validators.add(MaxLengthValidator(
          ValidatorVariables.TEXT_INPUT_MAX_LENGTH,
          errorText: ValidatorVariables.REQUIRE_MAX_VALUE));
    }
    if (validateEmail == true) {
      validators.add(
          EmailValidator(errorText: ValidatorVariables.REQUIRE_EMAIL_VALUE));
    }
    final multiValidtor = MultiValidator(validators);

    return Container(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        maxLines: multiLine,
        keyboardType: inputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: typePassword == null ? false : true,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: HexColor(GlobalVariables.LINE_COLOR))),
          hintText: hintText,
          hintStyle: TextStyle(color: GlobalVariables.TEXT_COLOR, fontStyle: FontStyle.italic, fontSize: GlobalVariables.HINT_TEXT_SIZE),
        ),
        style: TextStyle(
            color: GlobalVariables.TEXT_COLOR,
            fontSize: GlobalVariables.INPUT_FIELD_SIZE),
        validator: multiValidtor,
        onChanged: (data) {
          if (onChanged != null) onChanged!(data);
        },
      ),
    );
  }
}
