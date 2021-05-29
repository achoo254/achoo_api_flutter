// To parse this JSON data, do
//
//     final collection = collectionFromJson(jsonString);

import 'dart:convert';

List<Collection> collectionFromJson(String str) => List<Collection>.from(json.decode(str).map((x) => Collection.fromJson(x)));

String collectionToJson(List<Collection> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Collection {
  Collection({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.details,
    required this.usersId,
  });

  final String id;
  final DateTime createdAt;
  final String name;
  final String details;
  final String usersId;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    name: json["name"],
    details: json["details"],
    usersId: json["usersId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "name": name,
    "details": details,
    "usersId": usersId,
  };
}
