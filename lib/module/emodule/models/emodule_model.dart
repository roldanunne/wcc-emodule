// To parse this JSON data, do
//
//     final eModuleModelList = eModuleModelListFromJson(jsonString);
//     final lessonList = lessonListFromJson(jsonString); 

import 'dart:convert';

List<EModuleModelList> eModuleModelListFromJson(String str) => List<EModuleModelList>.from(json.decode(str).map((x) => EModuleModelList.fromJson(x))); 
String eModuleModelListToJson(List<EModuleModelList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


List<LessonList> lessonListFromJson(String str) => List<LessonList>.from(json.decode(str).map((x) => LessonList.fromJson(x)));
String lessonListToJson(List<LessonList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EModuleModelList {
    int id;
    String title;
    String details; 
    List<LessonList> lesson;
    DateTime createdAt;

    EModuleModelList({
        required this.id,
        required this.title,
        required this.details, 
        required this.lesson,
        required this.createdAt,
    });

    factory EModuleModelList.fromJson(Map<String, dynamic> json) => EModuleModelList(
        id: json["id"],
        title: json["title"],
        details: json["details"], 
        lesson: List<LessonList>.from(json["lesson"].map((x) => LessonList.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "details": details, 
        "lesson": List<dynamic>.from(lesson.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
    };
}

class LessonList {
    int id;
    int moduleId;
    String title;
    String content;
    String reference;
    DateTime createdAt;

    LessonList({
        required this.id,
        required this.moduleId,
        required this.title,
        required this.content,
        required this.reference,
        required this.createdAt,
    });

    factory LessonList.fromJson(Map<String, dynamic> json) => LessonList(
        id: json["id"],
        moduleId: json["module_id"],
        title: json["title"],
        content: json["content"]??'',
        reference: json["reference"]??'',
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "module_id": moduleId,
        "title": title,
        "content": content,
        "reference": reference,
        "created_at": createdAt.toIso8601String(),
    };
}
