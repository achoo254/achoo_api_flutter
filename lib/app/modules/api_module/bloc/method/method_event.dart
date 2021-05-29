part of 'method_bloc.dart';

@immutable
abstract class MethodEvent extends Equatable {
  @override
  List<Method> get props => [];
}

class GetMethodEvent extends MethodEvent {}
