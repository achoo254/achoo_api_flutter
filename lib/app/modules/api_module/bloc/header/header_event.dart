part of 'header_bloc.dart';

@immutable
abstract class HeaderEvent extends Equatable {
  @override
  // TODO: implement props
  List<Header?> get props => [];
}

// ignore: must_be_immutable
class AddHeaderEvent extends HeaderEvent {
  @override
  // TODO: implement props
  List<Header?> get props => [];
}

// ignore: must_be_immutable
class RemoveHeaderEvent extends HeaderEvent {
  final int index;

  RemoveHeaderEvent({required this.index});
}
