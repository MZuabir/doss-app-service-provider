// To parse this JSON data, do
//
//     final userMoreInfoModel = userMoreInfoModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserMoreInfoModel userMoreInfoModelFromJson(String str) => UserMoreInfoModel.fromJson(json.decode(str));

String userMoreInfoModelToJson(UserMoreInfoModel data) => json.encode(data.toJson());

class UserMoreInfoModel {
    final Data data;
    final bool success;

    UserMoreInfoModel({
        required this.data,
        required this.success,
    });

    factory UserMoreInfoModel.fromJson(Map<String, dynamic> json) => UserMoreInfoModel(
        data: Data.fromJson(json["data"]),
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "success": success,
    };
}

class Data {
    final String name;
    final String userStatus;
    final String photoUrl;

    Data({
        required this.name,
        required this.userStatus,
        required this.photoUrl,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        userStatus: json["userStatus"],
        photoUrl: json["photoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "userStatus": userStatus,
        "photoUrl": photoUrl,
    };
}
