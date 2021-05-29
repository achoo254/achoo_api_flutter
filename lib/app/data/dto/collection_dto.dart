import 'package:achoo_api/app/data/model/api.dart';
import 'package:achoo_api/app/data/model/collection.dart';

class CollectionDto{
  Collection collection;
  List<Api> api;

  CollectionDto({required this.collection, required this.api});
}