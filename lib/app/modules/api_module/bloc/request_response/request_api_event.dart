part of 'request_api_bloc.dart';

@immutable
abstract class RequestApiEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RequestApiSendEvent extends RequestApiEvent {
  final String requestUrl;
  final String methodName;
  final List<Header>? headerList;
  final List<Parameter>? parameterList;
  final String? body;

  RequestApiSendEvent(
      {required this.requestUrl,
      required this.methodName,
      this.headerList,
      this.parameterList,
      this.body});

  @override
  List<Object?> get props =>
      [requestUrl, methodName, headerList, parameterList, body];
}

class SaveApiEvent extends RequestApiEvent {
  final String requestUrl;
  final String methodId;
  final List<Header> headerList;
  final List<Parameter> parameterList;
  final String body;
  final String requestName;
  final String collectionId;
  final String collectionName;

  SaveApiEvent(
      {required this.requestUrl,
        required this.methodId,
        required this.headerList,
        required this.parameterList,
        required this.body, required this.requestName, required this.collectionId, required this.collectionName});
}
