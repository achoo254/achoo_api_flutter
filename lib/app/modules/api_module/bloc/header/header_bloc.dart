import 'dart:async';

import 'package:achoo_api/app/data/model/header.dart';
import 'package:achoo_api/app/data/repository/header_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'header_event.dart';
part 'header_state.dart';

class HeaderBloc extends Bloc<HeaderEvent, HeaderState> {
  //Gọi repo
  HeaderRepository headerRepository = HeaderRepository();
  //Init data
  HeaderBloc() : super(InitialHeaderState());
  List<Header> headerList = [];

  //Tạo 1 cái quản lý state, đảm nhận nhiệm vụ truyền state đến UI
  var _stateController = BehaviorSubject<HeaderState>();

  ValueStream<HeaderState> get stream => _stateController;

  @override
  Stream<HeaderState> mapEventToState(HeaderEvent event) async* {
    if (event is AddHeaderEvent) {
      Header header =
          Header(key: '', value: '', createdAt: DateTime.now(), id: '', apiId: '');
      headerList.add(header);
      _stateController.add(AddHeaderStateLoaded(headerList: headerList));
    } else if (event is RemoveHeaderEvent) {
      headerList.removeAt(event.index);
      _stateController.add(AddHeaderStateLoaded(headerList: headerList));
    }
  }

  // khi không cần thiết thì close tất cả controller
  void dispose() async {
    headerList.clear();
    _stateController.close();
  }
}
