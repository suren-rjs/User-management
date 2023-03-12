import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String username;
  @HiveField(1)
  String contact;
  @HiveField(2)
  String password;
  @HiveField(3)
  String? profileImgUrl;
  @HiveField(4)
  String? id;
  @HiveField(5)
  bool isActive;

  User({
    required this.username,
    required this.password,
    required this.contact,
    this.profileImgUrl,
    this.id,
    this.isActive = true,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<dynamic, dynamic> json) => User(
        username: json["username"],
        password: json["password"],
        contact: json["contact"],
        profileImgUrl: json["profileImgUrl"],
        id: json["id"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "contact": contact,
        "profileImgUrl": profileImgUrl,
        "id": id,
        "isActive": isActive,
      };
}
