// ignore_for_file: prefer_const_constructors

import 'package:etutor_project/pages/AddLesson.dart';
import 'package:etutor_project/pages/AddQuestion.dart';
import 'package:etutor_project/pages/EditLesson.dart';
import 'package:etutor_project/pages/EditQuestion.dart';
import 'package:etutor_project/pages/StudentQuiz.dart';
import 'package:flutter/material.dart';
import 'package:etutor_project/pages/Home.dart';
import 'package:etutor_project/pages/StudentLesson.dart';
import 'package:etutor_project/pages/TeacherMenu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder:()=> MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const Home(),
          '/StudentLesson': (context) => const StudentLesson(),
          '/StudentLesson/StudentQuiz': (context) => const StudentQuiz(),
          '/TeacherMenu': (context) => const TeacherMenu(),
          '/TeacherMenu/AddQuestion': (context) => const AddQuestion(),
          '/TeacherMenu/EditQuestion': (context) => const EditQuestion(),
          '/TeacherMenu/AddLesson': (context) => const AddLesson(),
          '/TeacherMenu/EditLesson': (context) => const EditLesson(),
        },
      ),
      designSize: const Size(3840, 1953),
    );
  }
}
