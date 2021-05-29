// To parse this JSON data, do
//
//     final method = methodFromJson(jsonString);

import 'dart:convert';

List<Method> methodFromJson(String str) =>
    List<Method>.from(json.decode(str).map((x) => Method.fromJson(x)));

String methodToJson(List<Method> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Method {
  Method({
    required this.id,
    required this.createdAt,
    required this.name,
  });

  String id;
  DateTime createdAt;
  String name;

  factory Method.fromJson(Map<String, dynamic> json) => Method(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "name": name,
      };

  @override
  String toString() {
    return this.name.toString();
  }
}
