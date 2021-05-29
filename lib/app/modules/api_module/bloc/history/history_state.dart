part of 'history_bloc.dart';

@immutable
abstract class HistoryState extends Equatable {

  @override
  List<HistoryDto> get props {
    return [];
  }
}

class InitialHistoryState extends HistoryState {}

class ShowHistoryLoaded extends HistoryState{
  final List<HistoryDto> hitoryDtoList;

  ShowHistoryLoaded({required this.hitoryDtoList});

  @override
  List<HistoryDto> get props {
    return hitoryDtoList;
  }
}

class ShowHistoryLoading extends HistoryState{}

class ShowHistoryError extends HistoryState{
  final String error;

  ShowHistoryError({required this.error});
}