part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {}

class ShowHistoryEvent extends HistoryEvent{
}

class DeleteHistoryEvent extends HistoryEvent{
  final String id;
  final HistoryDto historyDto;
  DeleteHistoryEvent({required this.id, required this.historyDto});
}
