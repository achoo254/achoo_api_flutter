// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  Users({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
    required this.email,
    required this.password,
  });

  String id;
  DateTime createdAt;
  String name;
  String avatar;
  String email;
  String password;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    name: json["name"],
    avatar: json["avatar"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "name": name,
    "avatar": avatar,
    "email": email,
    "password": password,
  };
}
