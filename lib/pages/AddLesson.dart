// ignore_for_file: prefer_const_literals_to_create_immutables, file_names, prefer_final_fields

import 'package:etutor_project/Lesson.dart';
import 'package:flutter/material.dart';
import 'package:etutor_project/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:etutor_project/Course.dart';

class AddLesson extends StatefulWidget {
  const AddLesson({Key? key}) : super(key: key);

  @override
  _AddLessonState createState() => _AddLessonState();
}

class _AddLessonState extends State<AddLesson> {
  bool _showLesson = false;
  TextEditingController _contentController = TextEditingController(),
      _titleController = TextEditingController();
  String? _courseValue;
  Course? _courseChoice;

  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar('Enjoy your lesson'),
        backgroundColor: MY_BACKGROUND_COLOR,
        body: SingleChildScrollView(
          child: Padding(
            padding: myPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  //Choose course menu
                  child: createMenu('Courses', courseNames, _courseValue,
                      (String? newValue) {
                    setState(() {
                      _courseValue = newValue;
                      _courseChoice = courseMap![newValue];
                      _showLesson = true;
                    });
                  }, true),
                ),

                SizedBox(
                  height: 0.03.sh,
                ),

                //Show Lesson area after choosing course
                Visibility(
                    visible: _showLesson,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Title input field
                          SizedBox(
                            height: 0.08.sh,
                            width: 0.55.sw,
                            child: createTextField(_titleController, 1, null,
                                'Enter lesson title', 'Title'),
                          ),

                          SizedBox(
                            height: 0.02.sw,
                          ),

                          //Lesson content input field
                          createTextField(_contentController, 12, 1500,
                              'Enter your lesson', 'Lesson'),
                        ])),

                SizedBox(
                  height: 0.035.sh,
                ),

                //Submit button
                createSubmitButton(() {
                  setState(() {
                    _courseChoice!.lessonList.add(Lesson(
                        content: _contentController.text,
                        title: _titleController.text,
                        questionList: []));
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
