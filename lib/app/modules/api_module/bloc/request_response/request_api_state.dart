part of 'request_api_bloc.dart';

@immutable
abstract class RequestApiState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialRequestApiState extends RequestApiState {
  final responseApi;

  InitialRequestApiState({required this.responseApi});
}

class RequestApiLoading extends RequestApiState {}

class RequestApiLoaded extends RequestApiState {
  final responseApi;

  RequestApiLoaded({required this.responseApi});

  @override
  List<Object?> get props => [responseApi];
}

class RequestApiError extends RequestApiState {
  final error;

  RequestApiError({this.error});
}
