import 'package:achoo_api/app/data/model/header.dart';
import 'package:achoo_api/app/data/provider/header_provider.dart';

class HeaderRepository{
  HeaderProvider _headerProvider = HeaderProvider();

  Future<dynamic> saveAll(List<Header> items) {
    return _headerProvider.saveAll(items);
  }
}