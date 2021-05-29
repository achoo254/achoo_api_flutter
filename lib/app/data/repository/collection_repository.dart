import 'package:achoo_api/app/data/model/collection.dart';
import 'package:achoo_api/app/data/provider/collection_provider.dart';

class CollectionRepository{
  CollectionProvider provider = CollectionProvider();
  CollectionRepository({required this.provider});

  Future<List<Collection>> getAllData() {
    return provider.getAllData();
  }

  Future<dynamic> save(Collection item) {
    return provider.save(item);
  }

  Future<bool> deleteById(String id) {
    return provider.deleteById(id);
  }

}