part of 'method_bloc.dart';

@immutable
abstract class MethodState extends Equatable {
  @override
  List<Method> get props => [];
}

class InitialMethodState extends MethodState {}

class MethodLoading extends MethodState {}

class MethodLoaded extends MethodState {
  final List<Method> methodList;

  MethodLoaded({required this.methodList});

  @override
  List<Method> get props => methodList;
}

class MethodError extends MethodState {
  final error;

  MethodError({this.error});
}
