// To parse this JSON data, do
//
//     final api = apiFromJson(jsonString);

import 'dart:convert';

List<Api> apiFromJson(String str) => List<Api>.from(json.decode(str).map((x) => Api.fromJson(x)));

String apiToJson(List<Api> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Api {
  Api({
    this.id,
    required this.createdAt,
    required this.name,
    required this.url,
    required this.body,
    required this.subcribe,
    required this.methodId,
    required this.collectionId,
  });

  String? id;
  DateTime createdAt;
  String name;
  String url;
  String body;
  int subcribe;
  String methodId;
  String collectionId;

  factory Api.fromJson(Map<String, dynamic> json) => Api(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    name: json["name"],
    url: json["url"],
    body: json["body"],
    subcribe: json["subcribe"],
    methodId: json["method_id"],
    collectionId: json["collection_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "name": name,
    "url": url,
    "body": body,
    "subcribe": subcribe,
    "method_id": methodId,
    "collection_id": collectionId,
  };
}
