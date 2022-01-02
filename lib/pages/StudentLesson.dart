// ignore_for_file: file_names, prefer_const_literals_to_create_immutables

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:etutor_project/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:etutor_project/Lesson.dart';
import 'package:etutor_project/Course.dart';

class StudentLesson extends StatefulWidget {
  const StudentLesson({Key? key}) : super(key: key);

  @override
  _StudentLessonState createState() => _StudentLessonState();
}

class _StudentLessonState extends State<StudentLesson> {
  bool _showLessonButton = false, _showLesson = false;
  String? _courseValue, _lessonValue;
  Course? _courseChoice;
  Lesson? _lessonChoice;

  // ignore: prefer_final_fields
  List<String> _lessonList = [];

  // ignore: prefer_final_fields
  HashMap _lessonMap = HashMap<String, Lesson>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar('Enjoy your lesson'),
        backgroundColor: MY_BACKGROUND_COLOR,
        body: SingleChildScrollView(
          child: Padding(
            padding: myPadding,
            child: Column(
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

                  //Choose lesson to show button
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

                Visibility(
                    visible: _showLesson,
                    child: Column(
                      children: [
                        //Lesson title
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.sp),
                            color: Colors.black,
                          ),
                          child: SizedBox(
                            width: 0.5.sw,
                            height: 0.08.sh,
                            child: Center(
                                child: Text(
                              (_lessonChoice == null)
                                  ? ''
                                  : _lessonChoice!.title,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 0.05.sw),
                            )),
                          ),
                        ),

                        //Lesson content
                        DecoratedBox(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: SizedBox(
                            height: 0.45.sh,
                            width: 0.8.sw,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: myPadding,
                                child: Center(
                                  child: Text(
                                    (_lessonChoice == null)
                                        ? ''
                                        : _lessonChoice!.content,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 170.sp,
                                        wordSpacing: 0.1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 0.02.sh,
                        ),

                        //Quiz button
                        Align(
                            alignment: Alignment.centerRight,
                            child: createQuizButton()),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }

  //Create quiz button
  ElevatedButton createQuizButton() {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/StudentLesson/StudentQuiz',
              arguments: _lessonChoice!
                  .questionList); //Navigate to quiz page and attach the list of questions in the current lesson
        },
        style: ElevatedButton.styleFrom(
            fixedSize: Size(0.3.sw, 0.08.sh),
            primary: const Color(0xFF000000),
            shape: RoundedRectangleBorder(borderRadius: MY_BORDER_RADIUS)),
        child: const Center(
          child: Text(
            'Quiz',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }
}
