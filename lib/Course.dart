// ignore_for_file: file_names

import 'dart:collection';

import 'package:etutor_project/Lesson.dart';

class Course {
  List<Lesson> lessonList;
  static List<Course> courseList = [];

  Course({required this.lessonList}) {
    courseList.add(this);
  }
}

List<String> courseNames = ['Course 1', 'Course 2', 'Course 3'];
HashMap<String, Course>? courseMap;
