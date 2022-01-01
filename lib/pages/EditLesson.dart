// ignore_for_file: prefer_const_literals_to_create_immutables, file_names, prefer_final_fields

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:etutor_project/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:etutor_project/Lesson.dart';
import 'package:etutor_project/Course.dart';

class EditLesson extends StatefulWidget {
  const EditLesson({Key? key}) : super(key: key);

  @override
  _EditLessonState createState() => _EditLessonState();
}

class _EditLessonState extends State<EditLesson> {
  bool _showLessonButton = false, _showLesson = false;
  TextEditingController _contentController = TextEditingController(),
      _titleController = TextEditingController();
  String? _courseValue, _lessonValue;
  Course? _courseChoice;
  Lesson? _lessonChoice;
  List<String> _lessonList = [];
  HashMap _lessonMap = HashMap<String, Lesson>();

  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //Choose course button
                  createMenu('Courses', courseNames, _courseValue,
                      (String? newValue) {
                    setState(() {
                      _courseValue = newValue;
                      _courseChoice = courseMap![newValue];
                      _lessonList.clear();
                      _lessonMap.clear();
                      _lessonValue = null;
                      _showLesson = false;
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

                  //Choose lesson to edit button
                  createMenu('Lessons', _lessonList, _lessonValue,
                      (String? newValue) {
                    setState(() {
                      _lessonValue = newValue;
                      _lessonChoice = _lessonMap[newValue];
                      _showLesson = true;
                    });
                  }, _showLessonButton)
                ]),

                SizedBox(
                  height: 0.03.sh,
                ),

                //Show the lesson area to be edited
                Visibility(
                    visible: _showLesson,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 0.08.sh,
                            width: 0.55.sw,

                            //Fetch and show the current title for editing
                            child: createTextField(
                                _titleController,
                                1,
                                null,
                                (_lessonChoice == null)
                                    ? ''
                                    : _lessonChoice!.title,
                                'Title'),
                          ),

                          SizedBox(
                            height: 0.02.sw,
                          ),

                          //Fetch and show the current lesson content for editing
                          createTextField(
                              _contentController,
                              12,
                              1500,
                              (_lessonChoice == null)
                                  ? ''
                                  : _lessonChoice!.content,
                              'Lesson'),
                        ])),

                SizedBox(
                  height: 0.035.sh,
                ),

                //Submit form button
                createSubmitButton(() {
                  setState(() {
                    _lessonChoice!.content = _contentController.text;
                    _lessonChoice!.title = _titleController.text;
                  });
                  _contentController.clear();
                  _titleController.clear();
                }, _showLesson)
              ],
            ),
          ),
        ));
  }
}
