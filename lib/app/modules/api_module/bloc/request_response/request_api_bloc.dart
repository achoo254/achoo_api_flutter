import 'dart:async';

import 'package:achoo_api/app/data/model/api.dart';
import 'package:achoo_api/app/data/model/collection.dart';
import 'package:achoo_api/app/data/model/header.dart';
import 'package:achoo_api/app/data/model/parameter.dart';
import 'package:achoo_api/app/data/provider/api_provider.dart';
import 'package:achoo_api/app/data/provider/collection_provider.dart';
import 'package:achoo_api/app/data/repository/api_repository.dart';
import 'package:achoo_api/app/data/repository/collection_repository.dart';
import 'package:achoo_api/app/data/repository/header_repository.dart';
import 'package:achoo_api/app/data/repository/parameter_repository.dart';
import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'request_api_event.dart';
part 'request_api_state.dart';

class RequestApiBloc extends Bloc<RequestApiEvent, RequestApiState> {
  //Tạo giá trị để chuyển tab
  late TabController tabController;
  //Tạo các giá trị trong form request
  final formKey = GlobalKey<FormState>();
  final requestInputController = TextEditingController();
  final bodyInputController = TextEditingController();
  List<TextEditingController> keyHeaderController = [];
  List<TextEditingController> valueHeaderController = [];
  List<TextEditingController> keyParameterController = [];
  List<TextEditingController> valueParameterController = [];
  //Khởi tạo đối tượng save request
  final nameRequestInputController = TextEditingController();
  final createCollectionInputController = TextEditingController();
  //Khởi tạo đối tượng item collection được chọn
  var collectionSelected;
  //Khởi tạo đối tượng item method được chọn
  var methodSelected;
  //Tạo đối tượng init state
  RequestApiBloc()
      : super(InitialRequestApiState(responseApi: new List.empty()));

  //Tạo đối tượng repo
  final ApiRepository apiRepository = ApiRepository(apiProvider: ApiProvider());
  final CollectionRepository collectionRepository = CollectionRepository(provider: CollectionProvider());
  final HeaderRepository headerRepository = HeaderRepository();
  final ParameterRepository parameterRepository = ParameterRepository();

  //Tạo 1 cái quản lý state, đảm nhận nhiệm vụ truyền state đến UI
  var _stateController = BehaviorSubject<RequestApiState>();

  ValueStream<RequestApiState> get requestApiStream => _stateController;

  @override
  Stream<RequestApiState> mapEventToState(RequestApiEvent event) async* {
    RequestApiLoading();
    // lắng nghe khi eventController push event mới
    if (event is RequestApiSendEvent) {
      // add state mới vào stateController để bên UI nhận được
      _stateController.add(RequestApiLoaded(
          responseApi: await apiRepository.requestApi(
              event.methodName,
              event.requestUrl,
              event.headerList!,
              event.parameterList!,
              event.body!)));
    }
    if(event is SaveApiEvent){
      String requestName = '';
      String collectionId = '';
      String collectionName = '';
      //Đầu tiên check nếu request là rỗng thì gán giá trị mặc định
      if(event.requestName.isEmpty){
        requestName = 'New request';
      }
      //Tiêp theo check nếu collectionname rỗng hay không
      if(event.collectionName.isEmpty){
        //collectionName bằng rỗng nên hiểu là lấy theo collectionid đã chọn
        collectionId = event.collectionId;
        //Check nếu collectionId bằng 0 tức là chưa có collection nào, save mới
        if(collectionId == '0'){
          collectionName = 'New collection';
          Collection collection = Collection(id: 'id', usersId: GlobalVariables.users.id, createdAt: DateTime.now(), name: collectionName, details: '');
          collection = await collectionRepository.save(collection);
          collectionId = collection.id;
        }
      }
      //Check cuối cùng nếu collectionName ko rỗng thì không quan tâm đã chọn collection nào, save mới luôn
      else{
        collectionName = event.collectionName;
        Collection collection = Collection(id: 'id', usersId: GlobalVariables.users.id, createdAt: DateTime.now(), name: collectionName, details: '');
        collection = await collectionRepository.save(collection);
        collectionId = collection.id;
      }
      //Save api
      Api api = Api(createdAt: DateTime.now(), name: requestName, url: event.requestUrl, body: event.body, subcribe: 0, methodId: event.methodId, collectionId: collectionId);
      //Check nếu header và parameter không rỗng thì save mới
      apiRepository.saveApi(api).then((value) async {
        if(event.headerList.isNotEmpty){
          List<Header> headerListNew = [];
          for(Header header in event.headerList){
            header.apiId = value.id;
            headerListNew.add(header);
          }
          await headerRepository.saveAll(headerListNew);
        }
        if(event.parameterList.isNotEmpty){
          List<Parameter> parameterListNew = [];
          for(Parameter parameter in event.parameterList){
            parameter.apiId = value.id;
            parameterListNew.add(parameter);
          }
          await parameterRepository.saveAll(event.parameterList);
        }
      });
    }
  }

  // khi không cần thiết thì close tất cả controller
  void dispose() async {
    tabController.dispose();
    keyHeaderController.clear();
    valueHeaderController.clear();
    keyParameterController.clear();
    valueParameterController.clear();
    _stateController.close();
  }
}
