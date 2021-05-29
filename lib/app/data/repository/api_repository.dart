import 'package:achoo_api/app/data/model/api.dart';
import 'package:achoo_api/app/data/model/header.dart';
import 'package:achoo_api/app/data/model/parameter.dart';
import 'package:achoo_api/app/data/provider/api_provider.dart';

class ApiRepository {
  ApiProvider apiProvider = ApiProvider();
  ApiRepository({required this.apiProvider});
  Future<List<Api>> getAllApi() {
    return apiProvider.getAllApi();
  }

  Future<dynamic> saveApi(Api item) {
    return apiProvider.saveApi(item);
  }

  Future<bool> deleteById(String id) {
    return apiProvider.deleteById(id);
  }

  Future<dynamic> requestApi(String method, String requestUrl,
      List<Header> headerList, List<Parameter> parameterList, String body) {
    return apiProvider.requestApi(
        method, requestUrl, headerList, parameterList, body);
  }
}
