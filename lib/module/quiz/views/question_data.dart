import 'package:auto_size_text_plus/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wcc_emodule/module/global/app_theme.dart';
import 'package:wcc_emodule/module/quiz/controllers/quiz_ctrl.dart';

class QuestionData extends StatefulWidget {
  final int index; 
  final String question;
  final String a;
  final String b;
  final String c;
  final String d;
  final String answer;
  final String explanation;

  const QuestionData({
    Key? key, 
    required this.index,  
    required this.question, 
    required this.a, 
    required this.b, 
    required this.c, 
    required this.d, 
    required this.answer, 
    required this.explanation
  }) : super(key: key);

  @override
  QuestionDataState createState() => QuestionDataState();
}

class QuestionDataState extends State<QuestionData> {

  QuizController ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    
    final randomOrdered = [
      Obx(() => Container(  
          margin: const EdgeInsets.only(bottom:10.0),
          decoration: AppTheme.containerBoxDecoration(bgColor:(ctrl.correctAnswerList[widget.index]=='a'&&ctrl.isQuestionLocked[widget.index])?AppTheme.green:AppTheme.whiteSmoke),
          child: RadioListTile<String>(
            title: Text(
              widget.a,
              style: AppTheme.dynamicStyle(color: AppTheme.greyDark, size:18.0, weight:FontWeight.w600),
            ),
            value: 'a',
            activeColor: AppTheme.black,
            groupValue: ctrl.userAnswerList[widget.index],
            onChanged: (value) {
              if(ctrl.isQuestionLocked[widget.index]){
                null; 
              } else{
                ctrl.userAnswerList[widget.index] = value!;
              }
            }, 
          ),
        ),
      ),
      Obx(() => Container(  
          margin: const EdgeInsets.only(bottom:10.0),
          decoration: AppTheme.containerBoxDecoration(bgColor:(ctrl.correctAnswerList[widget.index]=='b'&&ctrl.isQuestionLocked[widget.index])?AppTheme.green:AppTheme.whiteSmoke),
          child: RadioListTile<String>(
            title: Text(
              widget.b,
              style: AppTheme.dynamicStyle(color: AppTheme.greyDark, size:18.0, weight:FontWeight.w600),
            ),
            value: 'b',
            activeColor: AppTheme.black,
            groupValue: ctrl.userAnswerList[widget.index],
            onChanged: (value) {
              if(ctrl.isQuestionLocked[widget.index]){
                null; 
              } else{
                ctrl.userAnswerList[widget.index] = value!;
              }
            }, 
          ),
        ),
      ),
      Obx(() => Container(  
          margin: const EdgeInsets.only(bottom:10.0),
          decoration: AppTheme.containerBoxDecoration(bgColor:(ctrl.correctAnswerList[widget.index]=='c'&&ctrl.isQuestionLocked[widget.index])?AppTheme.green:AppTheme.whiteSmoke),
          child: RadioListTile<String>(
            title: Text(
              widget.c,
              style: AppTheme.dynamicStyle(color: AppTheme.greyDark, size:18.0, weight:FontWeight.w600),
            ),
            value: 'c',
            activeColor: AppTheme.black,
            groupValue: ctrl.userAnswerList[widget.index],
            onChanged: (value) {
              if(ctrl.isQuestionLocked[widget.index]){
                null; 
              } else{
                ctrl.userAnswerList[widget.index] = value!;
              }
            }, 
          ),
        ),
      ),
      Obx(() => Container(  
          margin: const EdgeInsets.only(bottom:10.0),
          decoration: AppTheme.containerBoxDecoration(bgColor:(ctrl.correctAnswerList[widget.index]=='d'&&ctrl.isQuestionLocked[widget.index])?AppTheme.green:AppTheme.whiteSmoke),
          child: RadioListTile<String>(
            title: Text(
              widget.d,
              style: AppTheme.dynamicStyle(color: AppTheme.greyDark, size:18.0, weight:FontWeight.w600),
            ),
            value: 'd',
            activeColor: AppTheme.black,
            groupValue: ctrl.userAnswerList[widget.index],
            onChanged: (value) {
              if(ctrl.isQuestionLocked[widget.index]){
                null; 
              } else{
                ctrl.userAnswerList[widget.index] = value!;
              }
            }, 
          ),
        ),
      ),
    ];
    randomOrdered.shuffle();

    return Obx(() => SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[ 
          Text(
            widget.question,
            style: AppTheme.dynamicStyle(color: AppTheme.greyDark, size:16.0, weight:FontWeight.w700),
          ),
          const SizedBox(height: 20), 
          Container(
            padding: const EdgeInsets.all(10.0),
            color: (ctrl.isQuestionLocked[widget.index])?AppTheme.volcanoHaze:AppTheme.white,
            child: Column(
              children: [
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[...randomOrdered
                  ]
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: AppTheme.black, height:1, thickness:1),
          const SizedBox(height: 20),
          if(ctrl.isQuestionLocked[widget.index])
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Answer:",
                style: AppTheme.dynamicStyle(color: AppTheme.greyDark, size:18.0, weight:FontWeight.w600),
              ),
              if(ctrl.correctAnswerList[widget.index]=='a')
              Text(
                widget.a,
                style: AppTheme.dynamicStyle(color: AppTheme.black, size:16.0, weight:FontWeight.w400),
              ),
              if(ctrl.correctAnswerList[widget.index]=='b')
              Text(
                widget.b,
                style: AppTheme.dynamicStyle(color: AppTheme.black, size:16.0, weight:FontWeight.w400),
              ),
              if(ctrl.correctAnswerList[widget.index]=='c')
              Text(
                widget.c,
                style: AppTheme.dynamicStyle(color: AppTheme.black, size:16.0, weight:FontWeight.w400),
              ),
              if(ctrl.correctAnswerList[widget.index]=='d')
              Text(
                widget.d,
                style: AppTheme.dynamicStyle(color: AppTheme.black, size:16.0, weight:FontWeight.w400),
              ),
              const SizedBox(height: 20),
              const Divider(color: AppTheme.black, height:1, thickness:1),
              const SizedBox(height: 20),
            ],
          ),
          if(ctrl.isQuestionLocked[widget.index] && widget.explanation.isNotEmpty && widget.explanation !='null')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Explanation:",
                style: AppTheme.dynamicStyle(color: AppTheme.greyDark, size:18.0, weight:FontWeight.w600),
              ),
              Text(
                widget.explanation,
                style: AppTheme.dynamicStyle(color: AppTheme.black, size:16.0, weight:FontWeight.w400),
              ),
              const SizedBox(height: 20),
              const Divider(color: AppTheme.black, height:1, thickness:1),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    ),
    );
  }
}
