// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);
//     final questionList = questionListFromJson(jsonString); 

import 'dart:convert';

List<QuizModel> quizModelFromJson(String str) => List<QuizModel>.from(json.decode(str).map((x) => QuizModel.fromJson(x))); 
String quizModelToJson(List<QuizModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<QuestionList> questionListFromJson(String str) => List<QuestionList>.from(json.decode(str).map((x) => QuestionList.fromJson(x)));
String questionListToJson(List<QuestionList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuizModel {
    int id;
    int moduleId;
    String title;
    int totalQuestion;
    String moduleTitle;
    List<QuestionList> questionList;

    QuizModel({
        required this.id,
        required this.moduleId,
        required this.title,
        required this.totalQuestion,
        required this.moduleTitle,
        required this.questionList,
    });

    factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        id: json["id"],
        moduleId: json["module_id"],
        title: json["title"],
        totalQuestion: json["total_question"],
        moduleTitle: json["module_title"],
        questionList: List<QuestionList>.from(json["question_list"].map((x) => QuestionList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "module_id": moduleId,
        "title": title,
        "total_question": totalQuestion,
        "module_title": moduleTitle,
        "question_list": List<dynamic>.from(questionList.map((x) => x.toJson())),
    };
}

class QuestionList {
    int id;
    int quizId;
    String question;
    String answerA;
    String answerB;
    String answerC;
    String answerD;
    String answer;
    String explanation;

    QuestionList({
        required this.id,
        required this.quizId,
        required this.question,
        required this.answerA,
        required this.answerB,
        required this.answerC,
        required this.answerD,
        required this.answer,
        required this.explanation,
    });

    factory QuestionList.fromJson(Map<String, dynamic> json) => QuestionList(
        id: json["id"],
        quizId: json["quiz_id"],
        question: json["question"].toString(),
        answerA: json["answer_a"].toString(),
        answerB: json["answer_b"].toString(),
        answerC: json["answer_c"].toString(),
        answerD: json["answer_d"].toString(),
        answer: json["answer"].toString(),
        explanation: json["explanation"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "quiz_id": quizId,
        "question": question,
        "answer_a": answerA,
        "answer_b": answerB,
        "answer_c": answerC,
        "answer_d": answerD,
        "answer": answer,
        "explanation": explanation,
    };
}
