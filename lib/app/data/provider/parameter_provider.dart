import 'dart:convert';

import 'package:achoo_api/app/data/model/parameter.dart';
import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:dio/dio.dart';

import 'endpoint_provider.dart';

class ParameterProvider{
  final String url = "/parameter";
  EndpointProvider _endpointProvider = EndpointProvider();

  Future<dynamic> saveAll(List<Parameter> items) async {
    try {
      items.forEach((item) async {
        Parameter parameter = Parameter(createdAt: DateTime.now(), key: item.key, value: item.value, apiId: item.apiId);
        String jsonBody = jsonEncode(parameter);
        Response response = await _endpointProvider
            .connectApi()
            .post(GlobalVariables.BASE_URL + url, data: jsonDecode(jsonBody));
        if (response.statusCode == 201) {
          print('Save parameter success');
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
      });
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
    return items;
  }
}