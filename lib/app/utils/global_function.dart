import 'package:intl/intl.dart';

class GlobalFunction{
  static getFormatedDate(String _date) {
    DateTime inputDateTime = DateTime.parse(_date);
    var dateFormat = DateFormat('dd-MM-yyyy');
    String outputFormat = dateFormat.format(inputDateTime).toString();
    return outputFormat;
  }
  static getFormatedDateWithTime(_date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
    return outputFormat.format(inputDate);
  }
}