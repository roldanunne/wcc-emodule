// To parse this JSON data, do
//
//     final settingModel = settingModelFromJson(jsonString);

import 'dart:convert';

SettingModel settingModelFromJson(String str) => SettingModel.fromJson(json.decode(str));

String settingModelToJson(SettingModel data) => json.encode(data.toJson());

class SettingModel {
    int id;
    String title;
    String details;

    SettingModel({
        required this.id,
        required this.title,
        required this.details,
    });

    factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
        id: json["id"],
        title: json["title"].toString(),
        details: json["details".toString()],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "details": details,
    };
}
