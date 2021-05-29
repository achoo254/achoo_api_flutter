// To parse this JSON data, do
//
//     final header = headerFromJson(jsonString);

import 'dart:convert';

List<Header> headerFromJson(String str) => List<Header>.from(json.decode(str).map((x) => Header.fromJson(x)));

String headerToJson(List<Header> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Header {
  Header({
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

  factory Header.fromJson(Map<String, dynamic> json) => Header(
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
