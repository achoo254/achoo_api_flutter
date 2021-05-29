part of 'parameter_bloc.dart';

@immutable
abstract class ParameterState extends Equatable {
  @override
  List<Parameter?> get props => [];
}

class InitialParameterState extends ParameterState {}

class AddParameterStateLoaded extends ParameterState {
  final List<Parameter> parameterList;

  AddParameterStateLoaded({required this.parameterList});

  @override
  List<Parameter?> get props => parameterList;
}
