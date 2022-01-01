// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:etutor_project/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: camel_case_types, prefer_generic_function_type_aliases

class TeacherMenu extends StatefulWidget {
  const TeacherMenu({Key? key}) : super(key: key);

  @override
  _TeacherMenuState createState() => _TeacherMenuState();
}

class _TeacherMenuState extends State<TeacherMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar,
        backgroundColor: MY_BACKGROUND_COLOR,
        body: Padding(
          padding: myPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  createElevatedButton('Add Question', 'AddQuestion'),
                  SizedBox(
                    width: 0.07.sw,
                  ),
                  createElevatedButton('Add Lesson', 'AddLesson'),
                ],
              ),
              SizedBox(
                height: 0.05.sh,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  createElevatedButton('Edit Question', 'EditQuestion'),
                  SizedBox(
                    width: 0.07.sw,
                  ),
                  createElevatedButton('Edit Lesson', 'EditLesson'),
                ],
              ),
            ],
          ),
        ));
  }

  ElevatedButton createElevatedButton(String text, String path) {
    ElevatedButton button = ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/TeacherMenu/$path');
        },
        style: ElevatedButton.styleFrom(
            fixedSize: Size(0.35.sw, 0.08.sh),
            primary: MY_BUTTON_COLOR,
            shape: RoundedRectangleBorder(borderRadius: MY_BORDER_RADIUS)),
        child: Center(
          child: MyText(text: text),
        ));
    return button;
  }
}
