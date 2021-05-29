import 'dart:async';

import 'package:achoo_api/app/data/model/method.dart';
import 'package:achoo_api/app/data/repository/method_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'method_event.dart';
part 'method_state.dart';

class MethodBloc extends Bloc<MethodEvent, MethodState> {
  //Khởi tạo repo
  final MethodRepository methodRepository = MethodRepository();

  //Tạo 1 cái quản lý state, đảm nhận nhiệm vụ truyền state đến UI
  var _stateController = BehaviorSubject<MethodState>();

  MethodBloc() : super(InitialMethodState());

  ValueStream<MethodState> get methodStream => _stateController;

  @override
  Stream<MethodState> mapEventToState(MethodEvent event) async* {
    MethodLoading();
    // lắng nghe khi eventController push event mới
    if (event is GetMethodEvent) {
      // add state mới vào stateController để bên UI nhận được
      _stateController
          .add(MethodLoaded(methodList: await methodRepository.getAllData()));
    }
  }

  // khi không cần thiết thì close tất cả controller
  void dispose() async {
    _stateController.drain();
  }
}
