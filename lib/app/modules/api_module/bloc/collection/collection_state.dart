part of 'collection_bloc.dart';

@immutable
abstract class CollectionState extends Equatable{

  @override
  List<Collection> get props => [];
}

class InitialCollectionState extends CollectionState {}

class CollectionLoading extends CollectionState {}

class CollectionLoaded extends CollectionState {
  final List<Collection> collectionList;

  CollectionLoaded({required this.collectionList});

  @override
  List<Collection> get props => collectionList;
}

class CollectionError extends CollectionState {
  final error;

  CollectionError({this.error});
}