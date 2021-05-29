part of 'header_bloc.dart';

@immutable
abstract class HeaderState extends Equatable {
  @override
  List<Header?> get props => [];
}

class InitialHeaderState extends HeaderState {}

class AddHeaderStateLoaded extends HeaderState {
  final List<Header> headerList;

  AddHeaderStateLoaded({required this.headerList});

  @override
  List<Header?> get props => headerList;
}
