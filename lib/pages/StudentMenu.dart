// ignore_for_file: file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:etutor_project/global.dart';

// ignore: unused_import
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentMenu extends StatefulWidget {
  const StudentMenu({Key? key}) : super(key: key);

  @override
  _StudentMenuState createState() => _StudentMenuState();
}

class _StudentMenuState extends State<StudentMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar,
        backgroundColor: MY_BACKGROUND_COLOR,
        body: Padding(
          padding: myPadding,
          child: Column(
            children: [],
          ),
        ));
  }
}
