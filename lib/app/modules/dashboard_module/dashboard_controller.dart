import 'package:achoo_api/app/data/model/api.dart';
import 'package:achoo_api/app/data/model/collection.dart';
import 'package:achoo_api/app/data/repository/api_repository.dart';
import 'package:achoo_api/app/data/repository/collection_repository.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController with StateMixin{
  //Khởi tạo biến toàn cục
  static DashBoardController get to => Get.find();
  //Khởi tạo repo
  final CollectionRepository collectionRepository;
  final ApiRepository apiRepository;
  //Khởi tạo hàm dựng
  DashBoardController({required this.collectionRepository, required this.apiRepository});

  //Khởi tạo biến trả kết quả
  final _collectionList = <Collection>[].obs;

  // ignore: invalid_use_of_protected_member
  get collectionList => _collectionList.value;

  set collectionList(value) {
    _collectionList.value = value;
  }

  final _apiList = <Api>[].obs;

  // ignore: invalid_use_of_protected_member
  get apiList => _apiList.value;

  set apiList(value) {
    _apiList.value = value;
  }

  //Khởi tạo biến lỗi
  final _error = ''.obs;

  get error => _error.value;

  set error(value) {
    _error.value = value;
  }


  @override
  Future<void> onInit() async {
    await getAllCollection();
    await getAllApi();
    super.onInit();
  }

  getAllCollection() async {
    try {
      //loading
      change(collectionList, status: RxStatus.loading());
      //Init kết quả
      collectionList = await collectionRepository.getAllData();
      if (collectionList.length > 0) {
        //Sau khi duyệt hết các phần tử thông báo success
        change(collectionList, status: RxStatus.success());
      }
    } on Exception catch (e) {
      error = e.toString();
      change(collectionList, status: RxStatus.error(error));
    }
    update();
  }

  getAllApi() async {
    try {
      //loading
      change(apiList, status: RxStatus.loading());
      //Init kết quả
      apiList = await apiRepository.getAllApi();
      if (collectionList.length > 0) {
        //Sau khi duyệt hết các phần tử thông báo success
        change(apiList, status: RxStatus.success());
      }
    } on Exception catch (e) {
      error = e.toString();
      change(apiList, status: RxStatus.error(error));
    }
    update();
  }
}