// ignore_for_file: file_names, constant_identifier_names, prefer_generic_function_type_aliases

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: camel_case_types
typedef submitAction = void Function();
// ignore: camel_case_types
typedef myCallBack = void Function(String? s);

//App bar layout
AppBar myAppBar = AppBar(
  title: const Text('Choose What you want to do'),
  backgroundColor: const Color(0xFF000000),
  centerTitle: true,
);

AppBar createAppBar(String s) {
  return AppBar(
    title: Text(s),
    backgroundColor: const Color(0xFF000000),
    centerTitle: true,
  );
}

//COLORS
const Color MY_BACKGROUND_COLOR = Color(0xE9FFFFFF),
    MY_BUTTON_COLOR = Color(0xFFCBC998),
    MY_DISABLED_BUTTON_COLOR = Color(0x64CBC998);

//PAGE PADDING
EdgeInsetsGeometry myPadding =
    EdgeInsets.fromLTRB(0.05.sw, 0.03.sh, 0.05.sw, 0.02.sh);

//Text template
// ignore: must_be_immutable
class MyText extends StatefulWidget {
  String text;

  MyText({Key? key, required this.text}) : super(key: key);

  @override
  State<MyText> createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: const TextStyle(color: Colors.black),
    );
  }
}

//Border radius for all labels and buttons
// ignore: non_constant_identifier_names
BorderRadius MY_BORDER_RADIUS = BorderRadius.circular(80.sp);

//Text field used for input
TextField createTextField(TextEditingController controller, int? lines,
    int? length, String hintText, String labelText) {
  return TextField(
    controller: controller,
    autocorrect: true,
    maxLines: lines,
    maxLength: length,
    cursorColor: Colors.grey[600],
    decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: MY_BORDER_RADIUS,
            borderSide: const BorderSide(color: Colors.black)),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        labelText: labelText,
        alignLabelWithHint: true,
        labelStyle: TextStyle(fontSize: 0.045.sw, color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderRadius: MY_BORDER_RADIUS,
        )),
  );
}

//Button for submitting forms
Visibility createSubmitButton(submitAction f, bool isVisible) {
  return Visibility(
      visible: isVisible,
      child: ElevatedButton(
          onPressed: f,
          style: ElevatedButton.styleFrom(
              fixedSize: Size(0.4.sw, 0.08.sh),
              primary: const Color(0xFF000000),
              shape: RoundedRectangleBorder(borderRadius: MY_BORDER_RADIUS)),
          child: const Center(
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          )));
}

//Function used for creating the Drop Down Buttons of choices
DecoratedBox createMenu(String placeHolder, List<String> items, String? value,
    myCallBack f, bool isEnabled) {
  return DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: MY_BORDER_RADIUS,
      color: isEnabled ? MY_BUTTON_COLOR : MY_DISABLED_BUTTON_COLOR,
    ),
    child: Padding(
      padding: EdgeInsets.fromLTRB(0.03.sw, 0, 0.03.sw, 0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: MY_BUTTON_COLOR,
          iconSize: 0.08.sw,
          borderRadius: MY_BORDER_RADIUS,
          hint: MyText(
            text: placeHolder,
          ),
          onChanged: isEnabled ? f : null,
          alignment: AlignmentDirectional.center,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: Center(
                    child: MyText(
                  text: value,
                )));
          }).toList(),
        ),
      ),
    ),
  );
}

//Builds drop down buttons for a list of courses and lessons
Row createCourseLessonPair(String? coursesValue, bool lessonEnabled,
    bool coursesEnabled, String? lessonsValue, myCallBack f1, myCallBack f2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      createMenu(
          'Courses',
          ['Course 1', 'Course 2', 'Course 3'],
          //Courses Button
          coursesValue,
          f1,
          coursesEnabled),
      SizedBox(
        width: 0.05.sw,
      ),
      createMenu(
          'Lessons',
          ['Lesson 1', 'Lesson 2', 'Lesson 3'],
          //Lessons Button
          lessonsValue,
          f2,
          lessonEnabled),
    ],
  );
}
