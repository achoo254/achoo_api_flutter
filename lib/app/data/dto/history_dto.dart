import 'package:achoo_api/app/data/model/api.dart';
import 'package:achoo_api/app/data/model/method.dart';

class HistoryDto{
  String usersApiId;
  Api api;
  Method method;

  HistoryDto({required this.usersApiId, required this.api, required this.method});
}