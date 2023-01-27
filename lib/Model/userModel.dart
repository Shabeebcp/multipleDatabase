// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.userId,
        this.userName,
        this.password,
        this.isActive,
    });

    int? userId;
    String? userName;
    String? password;
    int? isActive;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["UserID"],
        userName: json["UserName"],
        password: json["Password"],
        isActive: json["IsActive"],
    );

    Map<String, dynamic> toJson() => {
        "UserID": userId,
        "UserName": userName,
        "Password": password,
        "IsActive": isActive,
    };
}
