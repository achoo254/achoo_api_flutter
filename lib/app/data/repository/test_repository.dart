import 'package:achoo_api/app/data/provider/test_provider.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class testRepository {
  final testProvider provider;

  testRepository({required this.provider});

  getUser(id) {
    return provider.getUser(id);
  }

  postUser(Map data) {
    return provider.postUser(data);
  }

}