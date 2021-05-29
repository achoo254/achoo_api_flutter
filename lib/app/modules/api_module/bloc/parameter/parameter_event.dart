part of 'parameter_bloc.dart';

@immutable
abstract class ParameterEvent extends Equatable {
  @override
  // TODO: implement props
  List<Parameter?> get props => [];
}

// ignore: must_be_immutable
class AddParameterEvent extends ParameterEvent {
  @override
  // TODO: implement props
  List<Parameter?> get props => [];
}

// ignore: must_be_immutable
class RemoveParameterEvent extends ParameterEvent {
  final int index;

  RemoveParameterEvent({required this.index});
}
