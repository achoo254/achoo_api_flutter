import 'package:achoo_api/app/modules/test_module/test_controller.dart';
import 'package:achoo_api/app/data/provider/test_provider.dart';
import 'package:achoo_api/app/data/repository/test_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class testBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => testController(repository: testRepository(provider: testProvider())));
  }
}