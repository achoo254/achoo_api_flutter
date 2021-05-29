import 'package:achoo_api/app/data/model/method.dart';
import 'package:achoo_api/app/data/provider/method_provider.dart';

class MethodRepository {
  MethodProvider _provider = MethodProvider();

  Future<List<Method>> getAllData() {
    return _provider.getAllData();
  }

  Future<Method> getById(String id) {
    return _provider.getById(id);
  }
}
