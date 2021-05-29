import 'package:achoo_api/app/data/provider/api_provider.dart';
import 'package:achoo_api/app/data/provider/users_api_provider.dart';
import 'package:achoo_api/app/data/repository/api_repository.dart';
import 'package:achoo_api/app/data/repository/users_api_repository.dart';
import 'package:achoo_api/app/modules/collection_module/collection_controller.dart';
import 'package:achoo_api/app/data/provider/collection_provider.dart';
import 'package:achoo_api/app/data/repository/collection_repository.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class CollectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CollectionController(usersApiRepository: UsersApiRepository(provider: UsersApiProvider()), apiRepository: ApiRepository(apiProvider: ApiProvider()), collectionRepository: CollectionRepository(provider: CollectionProvider())));
  }
}