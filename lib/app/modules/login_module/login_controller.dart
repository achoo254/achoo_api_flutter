import 'package:achoo_api/app/data/model/users.dart';
import 'package:achoo_api/app/data/repository/login_repository.dart';
import 'package:achoo_api/app/routes/app_pages.dart';
import 'package:achoo_api/app/theme/error_exception.dart';
import 'package:achoo_api/app/theme/my_dialog.dart';
import 'package:achoo_api/app/utils/encrypt_data.dart';
import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:achoo_api/app/utils/validator_variables.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class LoginController extends GetxController {
  final LoginRepository repository;
  LoginController({required this.repository});
  //Khởi tạo giá trị trên form
  final formKey = GlobalKey<FormState>();
  final inputEmailController = TextEditingController();
  final inputPasswordController = TextEditingController();
  //Khởi tạo đối tượng danh sách user
  List<Users> userList = [];
  //Khởi tạo đối tượng nhận kết quả
  Users users = Users(
      id: '',
      createdAt: DateTime.now(),
      name: 'name',
      avatar: 'avatar',
      email: 'email',
      password: 'password');
  //Khởi tạo đối tượng encrypt data
  EncryptData encryptData = EncryptData();
  //Khởi tạo đối tượng password đã mã hóa
  late String passwordHash;

  getAll() {
    repository.getAll().then((data) {
      userList = (data.body as List).map((i) => Users.fromJson(i)).toList();
    });
  }

  getByEmailAndPassword(String email, String passwordNonHash) {
    passwordHash = encryptData.encrypted(passwordNonHash);
    print(passwordHash);
    for (Users item in userList) {
      if (item.email == email && item.password == passwordHash) {
        users = item;
        break;
      }
    }
  }

  submitForm() {
    if (formKey.currentState!.validate()) {
      //Load danh sách user
      getAll();
      //Kiểm tra user tồn tại hay ko
      getByEmailAndPassword(
          inputEmailController.text.trim(), inputPasswordController.text);
      if (users.id == '') {
        Get.snackbar(ValidatorVariables.ERROR_VALUE, ValidatorVariables.INPUT_EMAIL_PASSWORD_INVALID,snackPosition: SnackPosition.BOTTOM);
      } else {
        if(GlobalVariables.dataStorage.read('users') != null){
          GlobalVariables.dataStorage.remove('users');
        }
        GlobalVariables.dataStorage.write("users", users);
        Get.offAllNamed(Routes.DASHBOARD);
      }
    }
  }
}
