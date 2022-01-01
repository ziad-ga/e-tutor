// ignore_for_file: file_names
import 'package:flutter/material.dart';

import 'global.dart';

class Question {
  String question, answer;

  //Function used for creating question and answer text fields
  static Visibility createTextArea(
      bool visible,
      TextEditingController controller,
      int lines,
      int length,
      String hintText,
      String labelText) {
    return Visibility(
      visible: visible,
      child: createTextField(controller, lines, length, hintText, labelText),
    );
  }

  Question({required this.question, required this.answer});
}

class WrittenQuestion extends Question {
  WrittenQuestion({required String question, required String answer})
      : super(question: question, answer: answer);
}

// ignore: camel_case_types
class MCQ_Question extends Question {
  String option1, option2, option3, option4;
  late final List<String> optionList;

  MCQ_Question(
      {required String question,
      required String answer,
      required this.option1,
      required this.option2,
      required this.option3,
      required this.option4})
      : super(question: question, answer: answer) {
    optionList = [option1, option2, option3, option4];
  }
}

const List<String> qTypes = ['Written', 'MCQ'];
