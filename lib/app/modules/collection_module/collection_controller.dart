import 'package:achoo_api/app/data/dto/collection_dto.dart';
import 'package:achoo_api/app/data/model/api.dart';
import 'package:achoo_api/app/data/model/collection.dart';
import 'package:achoo_api/app/data/model/users_api.dart';
import 'package:achoo_api/app/data/repository/api_repository.dart';
import 'package:achoo_api/app/data/repository/collection_repository.dart';
import 'package:achoo_api/app/data/repository/users_api_repository.dart';
import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class CollectionController extends GetxController with StateMixin {
  //Khởi tạo repo
  final CollectionRepository collectionRepository;
  final UsersApiRepository usersApiRepository;
  final ApiRepository apiRepository;

  //Khởi tạo hàm dựng
  CollectionController(
      {required this.usersApiRepository,
      required this.apiRepository,
      required this.collectionRepository});

  //Khởi tạo biến trả kết quả
  final _collectionDtoList = <CollectionDto>[].obs;

  // ignore: invalid_use_of_protected_member
  get collectionDtoList => _collectionDtoList.value;

  set collectionDtoList(value) {
    _collectionDtoList.value = value;
  }

  //Khởi tạo biến lỗi
  final _error = ''.obs;

  get error => _error.value;

  set error(value) {
    _error.value = value;
  }

  getAllCollection() async {
    try {
      //loading
      change(collectionDtoList, status: RxStatus.loading());
      //Init kết quả
      List<Collection> collectionList = await collectionRepository.getAllData();
      //Duyệt từng phần tử trong collection theo users
      await Future.forEach(collectionList, (Collection collections) async {
        if (collections.usersId == GlobalVariables.users.id) {
          CollectionDto collectionDto =
              CollectionDto(collection: collections, api: []);
          collectionDtoList.add(collectionDto);
        }
      });
      if (collectionDtoList.length > 0) {
        //Sau khi duyệt hết các phần tử thông báo success
        change(collectionDtoList, status: RxStatus.success());
      }
    } on Exception catch (e) {
      error = e.toString();
      change(collectionDtoList, status: RxStatus.error(error));
    }
  }

  getDetailCollection() async {
    try {
      //Init data
      List<Api> apiList = await apiRepository.getAllApi();
      //Duyệt từng phần tử trong collection đang có
      await Future.forEach(collectionDtoList, (CollectionDto collectionDtos) async {
        collectionDtos.api.clear();
        await Future.forEach(apiList, (Api apis) {
          if (apis.collectionId == collectionDtos.collection.id) {
            collectionDtos.api.add(apis);
          }
        });
      });
      return collectionDtoList;
    } on Exception catch (e) {
      error = e.toString();
      change(collectionDtoList, status: RxStatus.error(error));
    }
  }

  deleteCollection(CollectionDto items) async {
    try {
      //Duyệt từng phần tử api đang có trong collection trước
      await Future.forEach(items.api, (Api apis) async {
        String id = apis.id!;
        //Duyệt từng phần tử api id đang có trong usersApi
        List<UsersApi> usersApi = await usersApiRepository.getAll();
        await Future.forEach(usersApi, (UsersApi usersApis) async {
          //Xóa hết api trong usersApi
          await usersApiRepository.deleteById(usersApis.id);
        });
        //Sau đó xóa api trong Api
        await apiRepository.deleteById(id);
      });
      //Cuối cùng xóa collection
      bool deleteItem =
          await collectionRepository.deleteById(items.collection.id);
      if (deleteItem) {
        collectionDtoList.remove(items);
      }
    } on Exception catch (e) {
      error = e.toString();
      change(collectionDtoList, status: RxStatus.error(error));
    }
  }

  @override
  Future<void> onInit() async {
    getAllCollection();
    await getDetailCollection();
    super.onInit();
  }
}
