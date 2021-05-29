import 'package:achoo_api/app/data/provider/login_provider.dart';
import 'package:flutter/cupertino.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class LoginRepository {
  final LoginProvider provider;

  LoginRepository({required this.provider});

  getAll() {
    return provider.getAll();
  }
}