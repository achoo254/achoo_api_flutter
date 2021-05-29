import 'package:achoo_api/app/data/model/parameter.dart';
import 'package:achoo_api/app/data/provider/parameter_provider.dart';

class ParameterRepository{
  ParameterProvider _parameterProvider = ParameterProvider();

  Future<dynamic> saveAll(List<Parameter> items) {
    return _parameterProvider.saveAll(items);
  }
}