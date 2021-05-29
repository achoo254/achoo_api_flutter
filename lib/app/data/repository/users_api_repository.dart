import 'package:achoo_api/app/data/model/users_api.dart';
import 'package:achoo_api/app/data/provider/users_api_provider.dart';

class UsersApiRepository{
  UsersApiProvider provider = UsersApiProvider();
  UsersApiRepository({required this.provider});
  Future<List<UsersApi>> getAll() {
    return provider.getAll();
  }

  Future<UsersApi> getById(String id) {
    return provider.getById(id);
  }

  Future<bool> deleteById(String id) {
    return provider.deleteById(id);
  }
}