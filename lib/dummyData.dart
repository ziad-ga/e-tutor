// ignore_for_file: file_names

import 'package:etutor_project/Course.dart';
import 'package:etutor_project/Lesson.dart';
import 'package:etutor_project/Question.dart';

List<Course> innitCourses() {
  return [
    Course(lessonList: innitLessons(1)),
    Course(lessonList: innitLessons(2)),
    Course(lessonList: innitLessons(3))
  ];
}

List<Lesson> innitLessons(int courseNum) {
  if (courseNum == 1) {
    return [
      Lesson(
          content: 'content',
          title: 'This is Course 1',
          questionList: innitQuestions(3))
    ];
  } else if (courseNum == 2) {
    return [
      Lesson(
          content: 'content', title: "C2 L1", questionList: innitQuestions(1)),
      Lesson(
          content: 'content', title: 'C2 L2', questionList: innitQuestions(2)),
      Lesson(
          content: 'content', title: 'C2 L3', questionList: innitQuestions(1))
    ];
  } else if (courseNum == 3) {
    return [
      Lesson(
          content: 'content', title: 'C3 L1', questionList: innitQuestions(2)),
      Lesson(
          content: 'content', title: 'C3 L2', questionList: innitQuestions(4))
    ];
  } else {
    return [];
  }
}

List<dynamic> innitQuestions(int n) {
  List<dynamic> questions = [];
  for (int i = 0; i < n; i++) {
    questions
        .add(WrittenQuestion(question: 'Question demo?', answer: 'Answer demo'));
  }
  return questions;
}
