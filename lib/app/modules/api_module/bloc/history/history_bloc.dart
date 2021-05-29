import 'dart:async';
import 'package:achoo_api/app/data/dto/history_dto.dart';
import 'package:achoo_api/app/data/model/api.dart';
import 'package:achoo_api/app/data/model/users_api.dart';
import 'package:achoo_api/app/data/provider/api_provider.dart';
import 'package:achoo_api/app/data/provider/users_api_provider.dart';
import 'package:achoo_api/app/data/repository/api_repository.dart';
import 'package:achoo_api/app/data/repository/method_repository.dart';
import 'package:achoo_api/app/data/repository/users_api_repository.dart';
import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:achoo_api/app/data/model/method.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(InitialHistoryState());
  //Gọi repo
  ApiRepository apiRepository = ApiRepository(apiProvider: ApiProvider());
  MethodRepository methodRepository = MethodRepository();
  UsersApiRepository usersApiRepository = UsersApiRepository(provider: UsersApiProvider());
  //Tạo biến cho giao diện chính
  final List<HistoryDto> historyDtoList = [];
  //Định nghĩa stream
  var _stateController = BehaviorSubject<HistoryState>();
  ValueStream<HistoryState> get stream => _stateController;

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    try {
      _stateController.add(ShowHistoryLoading());
      if(event is ShowHistoryEvent){
        List<UsersApi> usersApiList = await usersApiRepository.getAll();
        List<Api> apiList = await apiRepository.getAllApi();
        //bắt đầu duyệt từng phần tử usersApiList để lấy usersId, mỗi usersId có trong usersApiList tương ứng 1 history
        await Future.forEach(usersApiList, (UsersApi usersApis) async {
          if(usersApis.userId == GlobalVariables.users.id){
            //Duyệt từng phần tử trong apiList để lấy thông tin Api
            await Future.forEach(apiList, (Api apis) async {
              if(usersApis.apiId == apis.id){
                //Gọi method để lấy tên method
                Method method = Method(id: 'id', createdAt: DateTime.now(), name: 'name');
                method = await methodRepository.getById(apis.methodId);
                //Set giá trị date của api theo usersApi
                apis.createdAt = usersApis.createdAt;
                //Tạo đối tượng history để lưu kết quả
                HistoryDto historyDto = HistoryDto(api: apis, method: method, usersApiId: usersApis.id);
                //Lưu kết quả vào danh sách hiển thị
                historyDtoList.add(historyDto);
              }
            });
          }
        });
        //Sau khi duyệt từng phần tử xong, trả kết quả bên state
        _stateController.add(ShowHistoryLoaded(hitoryDtoList: historyDtoList));
      }
      else if(event is DeleteHistoryEvent){
        bool deleteItem = await usersApiRepository.deleteById(event.id);
        if(deleteItem){
          historyDtoList.remove(event.historyDto);
          _stateController.add(ShowHistoryLoaded(hitoryDtoList: historyDtoList));
        }
      }
    } on Exception catch (e) {
      _stateController.addError(ShowHistoryError(error: e.toString()));
    }
  }

  // khi không cần thiết thì close tất cả controller
  void dispose() async {
    _stateController.drain();
  }
}
