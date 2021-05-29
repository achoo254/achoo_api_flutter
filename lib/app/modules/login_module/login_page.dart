
import 'package:achoo_api/app/modules/login_module/login_controller.dart';
import 'package:achoo_api/app/theme/background.dart';
import 'package:achoo_api/app/theme/logo.dart';
import 'package:achoo_api/app/theme/my_button_submit.dart';
import 'package:achoo_api/app/theme/my_input_field.dart';
import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class LoginPage extends GetWidget<LoginController> {

  _initDataUser(){
    Get.find<LoginController>().getAll();
  }

  @override
  Widget build(BuildContext context) {
    //Init data
    _initDataUser();
    
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
            onTap: () {
              //Ẩn bàn phím nếu chạm vào nơi khác bất kỳ
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                currentFocus.focusedChild!.unfocus();
              }
            },
            child: Stack(
              children: [
                Background(body: Container()),
                Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Logo(GlobalVariables.TEXT_LOGIN),
                    SizedBox(
                      height: 50,
                    ),
                    Expanded(child: Container(child: body())),
                  ],
                ),
              ],
            )));
  }

  Widget body() {
    return SingleChildScrollView(
      child: SizedBox(
        child: Row(
          children: [
            Expanded(child: Container()),
            Container(
              width: 330,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          HexColor(GlobalVariables.SECOND_COLOR),
                          HexColor(GlobalVariables.THIRD_COLOR)
                        ]),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        MyInputField(
                          controller: controller.inputEmailController,
                          validateMinLength: true,
                          validateMaxLength: true,
                          validateRequire: true,
                          validateEmail: true,
                          hintText: GlobalVariables.TEXT_EMAIL_HINT,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyInputField(
                          controller: controller.inputPasswordController,
                          validateRequire: true,
                          validateMinLength: true,
                          hintText: GlobalVariables.TEXT_PASSWORD_HINT,
                          typePassword: true,
                          inputType: TextInputType.visiblePassword,
                          multiLine: 1,
                        ),
                        TextButton(
                            child: Text(GlobalVariables.TEXT_FORGOT_PASSWORD),
                            onPressed: () {actionForgotPassword();}),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 150,
                          height: 40,
                          child: MyButtonSubmit(function: () {
                            Get.find<LoginController>().submitForm();
                          }, title: GlobalVariables.BUTTON_TEXT_SUBMIT,),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextButton(
                            child: Text(GlobalVariables.TEXT_REGISTER),
                            onPressed: () {actionRegister();}),
                      ],
                    ),
                  ),
                )),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  actionForgotPassword() {}

  actionRegister() {}
}
