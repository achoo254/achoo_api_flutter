import 'dart:async';
import 'package:achoo_api/app/data/model/collection.dart';
import 'package:achoo_api/app/data/provider/collection_provider.dart';
import 'package:achoo_api/app/data/repository/collection_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'collection_event.dart';

part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  //Khởi tạo repo
  final CollectionRepository repository = CollectionRepository(provider: CollectionProvider());

  //Tạo 1 cái quản lý state, đảm nhận nhiệm vụ truyền state đến UI
  var _stateController = BehaviorSubject<CollectionState>();

  CollectionBloc() : super(InitialCollectionState());

  ValueStream<CollectionState> get stream => _stateController;

  @override
  Stream<CollectionState> mapEventToState(CollectionEvent event) async* {
    CollectionLoading();
    // lắng nghe khi eventController push event mới
    if (event is GetCollectionEvent) {
      // add state mới vào stateController để bên UI nhận được
      _stateController
          .add(CollectionLoaded(collectionList: await repository.getAllData()));
    }
  }

  // khi không cần thiết thì close tất cả controller
  void dispose() async {
    _stateController.drain();
  }
}
