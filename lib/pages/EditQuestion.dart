// ignore_for_file: prefer_const_literals_to_create_immutables, file_names, prefer_final_fields

import 'dart:collection';
import 'package:etutor_project/Lesson.dart';
import 'package:flutter/material.dart';
import 'package:etutor_project/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:etutor_project/Question.dart';
import 'package:etutor_project/Course.dart';

class EditQuestion extends StatefulWidget {
  const EditQuestion({Key? key}) : super(key: key);

  @override
  _EditQuestionState createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  bool _showLessonButton = false,
      _showQuestionButton = false,
      _showQuestion = false,
      _showMCQ = false,
      _showWritten = false;
  TextEditingController _questionController = TextEditingController(),
      _answerController = TextEditingController();

  List<TextEditingController> _optionControllerList = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  String? _courseValue, _lessonValue, _questionValue;
  Course? _courseChoice;
  Lesson? _lessonChoice;
  dynamic _questionChoice;
  List<String> _lessonList = [], _questionList = [];
  HashMap _lessonMap = HashMap<String, Lesson>(),
      _questionMap = HashMap<String, dynamic>();

  // _EditQuestionState() {
  //   int count = 1;
  //   for (var lesson in Lesson.lessons) {
  //     _lessonList.add('Lesson $count');
  //     _lessonMap['Lesson $count'] = lesson;
  //     count++;
  //   }
  //   count = 1;
  //   for (var question in Question.questions) {
  //     _questionList.add('Question $count');
  //     _questionMap['Question $count'] = question;
  //     count++;
  //   }
  // }

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
                      _courseValue, (String? newValue) {
                    setState(() {
                      _courseValue = newValue;
                      _courseChoice = courseMap![newValue];
                      _lessonList.clear();
                      _lessonMap.clear();
                      _lessonValue = null;
                      _showQuestionButton = false;
                      _showQuestion = false;
                      _showMCQ = false;
                      _showWritten = false;
                      int count = 1;
                      for (var lesson in _courseChoice!.lessonList) {
                        _lessonList.add('Lesson $count');
                        _lessonMap['Lesson $count'] = lesson;
                        count++;
                      }
                      _showLessonButton = true;
                    });
                  }, true),

                  SizedBox(
                    width: 0.05.sw,
                  ),

                  //Lessons Menu
                  createMenu(
                      'Lessons',
                      _lessonList,
                      //Lessons Button
                      _lessonValue, (String? newValue) {
                    setState(() {
                      _lessonValue = newValue;
                      _lessonChoice = _lessonMap[newValue];
                      _questionList.clear();
                      _questionMap.clear();
                      _questionValue = null;
                      _showQuestion = false;
                      _showMCQ = false;
                      _showWritten = false;
                      int count = 1;
                      for (var question in _lessonChoice!.questionList) {
                        _questionList.add('Question $count');
                        _questionMap['Question $count'] = question;
                        count++;
                      }
                      _showQuestionButton = true;
                    });
                  }, _showLessonButton),
                ],
              ),

              SizedBox(
                height: 0.03.sh,
              ),

              //Choose question button
              Center(
                child: createMenu('Questions', _questionList, _questionValue,
                    (String? newValue) {
                  setState(() {
                    _questionValue = newValue;
                    _showQuestion = true;
                    _questionChoice = _questionMap[newValue];
                    if (_questionMap[newValue] is WrittenQuestion) {
                      _showMCQ = false;
                      _showWritten = true;
                    } else {
                      _showWritten = false;
                      _showMCQ = true;
                    }
                  });
                }, _showQuestionButton),
              ),

              SizedBox(
                height: 0.03.sh,
              ),

              //Question Area
              Question.createTextArea(
                  _showQuestion,
                  _questionController,
                  1,
                  70,
                  (_questionChoice == null) ? '' : _questionChoice!.question,
                  'Question'),

              SizedBox(
                height: 0.01.sh,
              ),

              //Answer Area

              //If answer is written
              Question.createTextArea(
                  _showWritten,
                  _answerController,
                  2,
                  140,
                  (_questionChoice == null) ? '' : _questionChoice!.answer,
                  'Answer'),

              //if answer is MCQ
              createMCQAnswerArea(),

              SizedBox(
                height: 0.035.sh,
              ),

              // Submit Button
              createSubmitButton(() {
                setState(() {
                  _questionChoice!.question = _questionController.text;
                  if (_questionChoice is WrittenQuestion) {
                    //Case of written
                    _questionChoice!.answer = _answerController.text;
                  } else if (_questionChoice is MCQ_Question) {
                    _questionChoice!.answer = _answerController.text;
                    _questionChoice!.option1 = _optionControllerList[0].text;
                    _questionChoice!.option2 = _optionControllerList[1].text;
                    _questionChoice!.option3 = _optionControllerList[2].text;
                    _questionChoice!.option4 = _optionControllerList[3].text;
                    for (var controller in _optionControllerList) {
                      controller.clear();
                    }
                  } else {}
                });
                _questionController.clear();
                _answerController.clear();
              }, _showQuestion)
            ],
          ),
        ),
      ),
    );
  }

  Visibility createMCQAnswerArea() {
    return Visibility(
        visible: _showMCQ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _createOptionField(
                (_questionChoice == null || _questionChoice is WrittenQuestion)
                    ? ''
                    : _questionChoice!.answer,
                'Answer',
                _answerController),
            SizedBox(
              height: 0.02.sh,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _createOptionField(
                    (_questionChoice == null ||
                            _questionChoice is WrittenQuestion)
                        ? ''
                        : _questionChoice!.option1,
                    'Option 1',
                    _optionControllerList[0]),
                SizedBox(
                  width: 0.04.sw,
                ),
                _createOptionField(
                    (_questionChoice == null ||
                            _questionChoice is WrittenQuestion)
                        ? ''
                        : _questionChoice!.option2,
                    'Option 2',
                    _optionControllerList[1]),
              ],
            ),
            SizedBox(
              height: 0.015.sh,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _createOptionField(
                    (_questionChoice == null ||
                            _questionChoice is WrittenQuestion)
                        ? ''
                        : _questionChoice!.option3,
                    'Option 3',
                    _optionControllerList[2]),
                SizedBox(
                  width: 0.04.sw,
                ),
                _createOptionField(
                    (_questionChoice == null ||
                            _questionChoice is WrittenQuestion)
                        ? ''
                        : _questionChoice!.option4,
                    'Option 4',
                    _optionControllerList[3]),
              ],
            )
          ],
        ));
  }

  //
  Center _createOptionField(
      String value, String label, TextEditingController controller) {
    return Center(
        child: SizedBox(
            width: 0.4.sw,
            height: 0.08.sh,
            child: createTextField(controller, 1, null, value, label)));
  }
}
