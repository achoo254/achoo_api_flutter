import 'dart:convert';

import 'package:achoo_api/app/data/model/api.dart';
import 'package:achoo_api/app/data/model/header.dart';
import 'package:achoo_api/app/data/model/parameter.dart';
import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:dio/dio.dart';
import 'endpoint_provider.dart';

class ApiProvider {
  final String url = "/api";
  EndpointProvider _endpointProvider = EndpointProvider();

  Future<List<Api>> getAllApi() async {
    List<Api> apiList = [];
    try {
      Response response = await _endpointProvider
          .connectApi()
          .get(GlobalVariables.BASE_URL + url);
      if (response.statusCode == 200) {
        apiList = (response.data as List).map((i) => Api.fromJson(i)).toList();
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }

    return apiList;
  }

  Future<dynamic> saveApi(Api item) async {
    try {
      Api api = Api(
          createdAt: DateTime.now(),
          name: item.name,
          url: item.url,
          body: item.body,
          subcribe: 0, collectionId: item.collectionId, methodId: item.methodId);
      String jsonBody = jsonEncode(api);
      Response response = await _endpointProvider
          .connectApi()
          .post(GlobalVariables.BASE_URL + url, data: jsonDecode(jsonBody));
      if (response.statusCode == 201) {
        print('Save api success');
        return Api.fromJson(response.data);
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

  Future<dynamic> requestApi(
      String method,
      String requestUrl,
      List<Header> headerList,
      List<Parameter> parameterList,
      String body) async {
    var responseData;
    Response? response;
    try {
      Dio connect = _endpointProvider.connectApi();
      //Chuyển list sang map header
      Map<String, String> headerMap = Map();
      for (var h in headerList) {
        if (h.value != '' && h.key != '') {
          headerMap.putIfAbsent(h.key, () => h.value);
        }
      }
      //Chuyển list sang map parameter
      Map<String, String> parameterMap = Map();
      for (var p in parameterList) {
        if (p.value != '' && p.key != '') {
          parameterMap.putIfAbsent(p.key, () => p.value);
        }
      }

      connect.options.headers = headerMap;
      connect.options.queryParameters = parameterMap;
      switch (method.toUpperCase()) {
        case "GET":
          response = await connect.get(requestUrl);
          break;
        case "POST":
          response = await connect.post(requestUrl,
              data: body.isEmpty ? "" : jsonDecode(body));
          break;
        case "PUT":
          response = await connect.put(requestUrl,
              data: body.isEmpty ? "" : jsonDecode(body));
          break;
        case "DELETE":
          response = await connect.delete(requestUrl);
          break;
      }

      if (response!.statusCode == 200) {
        responseData = response.data;
        return responseData;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }

    return responseData;
  }
}
