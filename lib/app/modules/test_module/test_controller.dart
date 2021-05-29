import 'package:achoo_api/app/data/repository/test_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class testController extends GetxController{

  final testRepository repository;

  testController({required this.repository});

  var _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
}
