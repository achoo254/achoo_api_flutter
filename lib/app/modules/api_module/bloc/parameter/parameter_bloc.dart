import 'dart:async';

import 'package:achoo_api/app/data/model/parameter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'parameter_event.dart';
part 'parameter_state.dart';

class ParameterBloc extends Bloc<ParameterEvent, ParameterState> {
  ParameterBloc() : super(InitialParameterState());
  List<Parameter> parameterList = [];

  //Tạo 1 cái quản lý state, đảm nhận nhiệm vụ truyền state đến UI
  var _stateController = BehaviorSubject<ParameterState>();

  ValueStream<ParameterState> get stream => _stateController;

  @override
  Stream<ParameterState> mapEventToState(ParameterEvent event) async* {
    if (event is AddParameterEvent) {
      Parameter header =
          Parameter(key: '', value: '', createdAt: DateTime.now(), id: '', apiId: '');
      parameterList.add(header);
      _stateController
          .add(AddParameterStateLoaded(parameterList: parameterList));
    } else if (event is RemoveParameterEvent) {
      parameterList.removeAt(event.index);
      _stateController
          .add(AddParameterStateLoaded(parameterList: parameterList));
    }
  }

  // khi không cần thiết thì close tất cả controller
  void dispose() async {
    parameterList.clear();
    _stateController.close();
  }
}
