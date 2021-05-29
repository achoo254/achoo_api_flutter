import 'package:achoo_api/app/data/model/users_api.dart';
import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:dio/dio.dart';

import 'endpoint_provider.dart';

class UsersApiProvider{
  final String url = "/users_api/";
  EndpointProvider _endpointProvider = EndpointProvider();

  Future<List<UsersApi>> getAll() async {
    List<UsersApi> list = [];
    try {
      Response response = await _endpointProvider
          .connectApi()
          .get(GlobalVariables.BASE_URL + url);
      if (response.statusCode == 200) {
        list = (response.data as List).map((i) => UsersApi.fromJson(i)).toList();
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }

    return list;
  }

  Future<UsersApi> getById(String id) async {
    //Init data
    UsersApi item = new UsersApi(id: 'id', createdAt: DateTime.now(), userId: 'userId', apiId: 'apiId');
    try {
      Response response = await _endpointProvider
          .connectApi()
          .get(GlobalVariables.BASE_URL + url + id);
      if (response.statusCode == 200) {
        item = UsersApi.fromJson(response.data);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }

    return item;
  }

  Future<bool> deleteById(String id) async {
    try {
      Response response = await _endpointProvider
          .connectApi()
          .delete(GlobalVariables.BASE_URL + url + id);
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }

    return false;
  }
}