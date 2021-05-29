import 'dart:convert';

import 'package:achoo_api/app/data/model/collection.dart';
import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:dio/dio.dart';

import 'endpoint_provider.dart';

class CollectionProvider {
  final String url = "/collection/";
  EndpointProvider _endpointProvider = EndpointProvider();

  Future<List<Collection>> getAllData() async {
    List<Collection> itemList = [];
    try {
      Response response = await _endpointProvider
          .connectApi()
          .get(GlobalVariables.BASE_URL + url);
      if (response.statusCode == 200) {
        itemList =
            (response.data as List).map((i) => Collection.fromJson(i)).toList();
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }

    return itemList;
  }

  Future<dynamic> save(Collection item) async {
    try {
      Collection collection = Collection(id: 'id', usersId: item.usersId,
          createdAt: DateTime.now(), name: item.name, details: item.details);
      String jsonBody = jsonEncode(collection);
      Response response = await _endpointProvider.connectApi().post(
          GlobalVariables.BASE_URL + url,
          data: jsonDecode(jsonBody));
      if (response.statusCode == 201) {
        print('Save collection success');
        return Collection.fromJson(response.data);
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
