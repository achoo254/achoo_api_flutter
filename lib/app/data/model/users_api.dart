// To parse this JSON data, do
//
//     final usersApi = usersApiFromJson(jsonString);

import 'dart:convert';

List<UsersApi> usersApiFromJson(String str) =>
    List<UsersApi>.from(json.decode(str).map((x) => UsersApi.fromJson(x)));

String usersApiToJson(List<UsersApi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersApi {
  UsersApi({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.apiId,
  });

  String id;
  DateTime createdAt;
  String userId;
  String apiId;

  factory UsersApi.fromJson(Map<String, dynamic> json) => UsersApi(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        userId: json["user_id"],
        apiId: json["api_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "user_id": userId,
        "api_id": apiId,
      };
}
