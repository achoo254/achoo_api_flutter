import 'package:achoo_api/app/modules/login_module/login_controller.dart';
import 'package:achoo_api/app/data/provider/login_provider.dart';
import 'package:achoo_api/app/data/repository/login_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(repository: LoginRepository(provider: LoginProvider())));
  }
}