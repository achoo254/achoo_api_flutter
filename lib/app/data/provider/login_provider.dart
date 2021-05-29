import 'package:achoo_api/app/utils/global_variables.dart';
import 'package:get/get_connect/connect.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class LoginProvider extends GetConnect {

  Future<Response> getAll() => get('${GlobalVariables.BASE_URL}/users/');

  // Get request example
  Future<Response> getUser(int id) => get('$baseUrl/users/id');

  // Post request example
  Future<Response> postUser(Map data) => post('$baseUrl/users', data);

}