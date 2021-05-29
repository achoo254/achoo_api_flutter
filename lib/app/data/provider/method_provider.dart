import 'package:achoo_api/app/data/model/method.dart';
import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:dio/dio.dart';

import 'endpoint_provider.dart';

class MethodProvider {
  final String url = "/method/";
  EndpointProvider _endpointProvider = EndpointProvider();

  Future<List<Method>> getAllData() async {
    List<Method> itemList = [];
    try {
      Response response = await _endpointProvider
          .connectApi()
          .get(GlobalVariables.BASE_URL + url);
      if (response.statusCode == 200) {
        itemList =
            (response.data as List).map((i) => Method.fromJson(i)).toList();
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }

    return itemList;
  }

  Future<Method> getById(String id) async {
    //Init data
    Method item = new Method(
        id: id, createdAt: DateTime.now(), name: GlobalVariables.EMPTY_VALUE);
    try {
      Response response = await _endpointProvider
          .connectApi()
          .get(GlobalVariables.BASE_URL + url + id);
      if (response.statusCode == 200) {
        item = Method.fromJson(response.data);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }

    return item;
  }
}
