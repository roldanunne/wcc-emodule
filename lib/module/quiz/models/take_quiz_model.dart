// To parse this JSON data, do
//
//     final takeQuizModel = takeQuizModelFromJson(jsonString);

import 'dart:convert';

List<TakeQuizModel> takeQuizModelFromJson(String str) => List<TakeQuizModel>.from(json.decode(str).map((x) => TakeQuizModel.fromJson(x)));

String takeQuizModelToJson(List<TakeQuizModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TakeQuizModel {
    int id;
    int userId;
    int quizId;
    int question;
    int score;
    String result;
    String title;
    DateTime createdAt;

    TakeQuizModel({
        required this.id,
        required this.userId,
        required this.quizId,
        required this.question,
        required this.score,
        required this.result,
        required this.title,
        required this.createdAt,
    });

    factory TakeQuizModel.fromJson(Map<String, dynamic> json) => TakeQuizModel(
        id: json["id"],
        userId: json["user_id"],
        quizId: json["quiz_id"],
        question: json["question"],
        score: json["score"],
        result: json["result"].toString(),
        title: json["title"].toString(),
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "quiz_id": quizId,
        "question": question,
        "score": score,
        "result": result,
        "title": title,
        "created_at": createdAt.toIso8601String(),
    };
}
