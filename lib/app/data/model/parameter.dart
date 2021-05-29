// To parse this JSON data, do
//
//     final parameter = parameterFromJson(jsonString);

import 'dart:convert';

List<Parameter> parameterFromJson(String str) => List<Parameter>.from(json.decode(str).map((x) => Parameter.fromJson(x)));

String parameterToJson(List<Parameter> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Parameter {
  Parameter({
    this.id,
    required this.createdAt,
    required this.key,
    required this.value,
    required this.apiId,
  });

  String? id;
  DateTime createdAt;
  String key;
  String value;
  String apiId;

  factory Parameter.fromJson(Map<String, dynamic> json) => Parameter(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    key: json["key"],
    value: json["value"],
    apiId: json["api_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "key": key,
    "value": value,
    "api_id": apiId,
  };
}
