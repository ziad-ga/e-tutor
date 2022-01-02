// ignore_for_file: file_names, camel_case_types, prefer_generic_function_type_aliases, avoid_function_literals_in_foreach_calls, prefer_final_fields

import 'dart:collection';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:etutor_project/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:etutor_project/Question.dart';
import 'package:etutor_project/Lesson.dart';
import 'package:etutor_project/Course.dart';

typedef myCallBack = void Function(String? s);

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  TextEditingController _questionController = TextEditingController(),
      _answerController = TextEditingController();

  List<TextEditingController> _optionControllerList = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  String? _coursesValue, _lessonValue, _qType;
  List<String> _options = [];
  bool _lessonEnabled = false,
      _qTypeEnabled = false,
      _showQuestionArea = false,
      _showWrittenAnswerArea = false,
      _showMCQAnswerArea = false;
  List<String> _lessonList = [];
  HashMap _lessonMap = HashMap<String, Lesson>();
  Course? _courseChoice;
  Lesson? _lessonChoice;

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    _optionControllerList.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar,
        backgroundColor: MY_BACKGROUND_COLOR,
        body: SingleChildScrollView(
          child: Padding(
            padding: myPadding,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Courses Menu
                    createMenu(
                        'Courses',
                        courseNames,
                        //Courses Button
                        _coursesValue, (String? newValue) {
                      setState(() {
                        _coursesValue = newValue;
                        _courseChoice = courseMap![newValue];
                        _lessonList.clear();
                        _lessonMap.clear();
                        _lessonValue = null;
                        _lessonEnabled = false;
                        _qTypeEnabled = false;
                        _showQuestionArea = false;
                        _showWrittenAnswerArea = false;
                        _showMCQAnswerArea = false;
                        int count = 1;
                        for (var lesson in _courseChoice!.lessonList) {
                          _lessonList.add('Lesson $count');
                          _lessonMap['Lesson $count'] = lesson;
                          count++;
                        }
                        _lessonEnabled = true;
                      });
                    }, true),

                    SizedBox(
                      width: 0.05.sw,
                    ),

                    //Lessons Menu
                    createMenu('Lessons', _lessonList, _lessonValue,
                        (String? newValue) {
                      setState(() {
                        _lessonValue = newValue;
                        _lessonChoice = _lessonMap[newValue];
                        _showQuestionArea = false;
                        _showWrittenAnswerArea = false;
                        _showMCQAnswerArea = false;
                        _qTypeEnabled = true;
                      });
                    }, _lessonEnabled),
                  ],
                ),

                SizedBox(
                  height: 0.03.sh,
                ),

                //Choose question type button
                Center(
                  child: createMenu('Question Type', qTypes, _qType,
                      (String? newValue) {
                    setState(() {
                      _qType = newValue;
                      _showQuestionArea = true;
                      if (_qType == qTypes[0]) {
                        _showWrittenAnswerArea = true;
                        _showMCQAnswerArea = false;
                      } else {
                        _showMCQAnswerArea = true;
                        _showWrittenAnswerArea = false;
                      }
                    });
                  }, _qTypeEnabled),
                ),

                SizedBox(
                  height: 0.03.sh,
                ),

                //Question Area
                Question.createTextArea(_showQuestionArea, _questionController,
                    1, 70, 'Enter your question', 'Question'),

                SizedBox(
                  height: 0.01.sh,
                ),

                //Answer Area

                //If answer is written
                Question.createTextArea(_showWrittenAnswerArea,
                    _answerController, 2, 140, 'Enter your answer', 'Answer'),
                //if answer is MCQ
                createMCQAnswerArea(),

                SizedBox(
                  height: 0.035.sh,
                ),

                //Submit Button
                createSubmitButton(() {
                  if (_qType == qTypes[0]) {
                    //Case of written
                    _lessonChoice!.questionList.add(WrittenQuestion(
                        answer: _answerController.text,
                        question: _questionController.text));
                  } else {
                    //MCQ case
                    setState(() {
                      _optionControllerList.forEach((controller) {
                        _options.add(controller.text);
                        controller.clear();
                      });
                      _lessonChoice!.questionList.add(MCQ_Question(
                          answer: _answerController.text,
                          option1: _options[0],
                          option2: _options[1],
                          option3: _options[2],
                          option4: _options[3],
                          question: _questionController.text));
                    });
                  }
                  _questionController.clear();
                  _answerController.clear();
                }, _showQuestionArea)
              ],
            ),
          ),
        ));
  }

  Visibility createMCQAnswerArea() {
    return Visibility(
        visible: _showMCQAnswerArea,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            createOptionField('Answer', _answerController),
            SizedBox(
              height: 0.02.sh,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                createOptionField('Option 1', _optionControllerList[0]),
                SizedBox(
                  width: 0.04.sw,
                ),
                createOptionField('Option 2', _optionControllerList[1])
              ],
            ),
            SizedBox(
              height: 0.015.sh,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                createOptionField('Option 3', _optionControllerList[2]),
                SizedBox(
                  width: 0.04.sw,
                ),
                createOptionField('Option 4', _optionControllerList[3])
              ],
            )
          ],
        ));
  }

  //
  Center createOptionField(String text, TextEditingController controller) {
    return Center(
        child: SizedBox(
            width: 0.4.sw,
            height: 0.08.sh,
            child: createTextField(controller, 1, null, text, text)));
  }
}
