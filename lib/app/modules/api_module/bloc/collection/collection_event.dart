part of 'collection_bloc.dart';

@immutable
abstract class CollectionEvent extends Equatable{
  @override
  List<Collection> get props => [];
}

class GetCollectionEvent extends CollectionEvent {}
