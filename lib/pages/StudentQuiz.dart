// ignore_for_file: file_names

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:etutor_project/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentQuiz extends StatefulWidget {
  const StudentQuiz({Key? key}) : super(key: key);

  @override
  _StudentQuizState createState() => _StudentQuizState();
}

class _StudentQuizState extends State<StudentQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar('Quiz'),
      backgroundColor: MY_BACKGROUND_COLOR,
      body: SingleChildScrollView(
        child: Padding(
          padding: myPadding,
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
