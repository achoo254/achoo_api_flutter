import 'package:achoo_api/app/data/provider/api_provider.dart';
import 'package:achoo_api/app/data/provider/collection_provider.dart';
import 'package:achoo_api/app/data/repository/api_repository.dart';
import 'package:achoo_api/app/data/repository/collection_repository.dart';
import 'package:achoo_api/app/modules/dashboard_module/dashboard_controller.dart';
import 'package:get/get.dart';

class DashBoardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DashBoardController(collectionRepository: CollectionRepository(provider: CollectionProvider()), apiRepository: ApiRepository(apiProvider: ApiProvider())));
  }

}