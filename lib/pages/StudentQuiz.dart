// ignore_for_file: file_names

import 'package:etutor_project/Question.dart';
import 'package:flutter/material.dart';
import 'package:etutor_project/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentQuiz extends StatefulWidget {
  const StudentQuiz({Key? key}) : super(key: key);

  @override
  _StudentQuizState createState() => _StudentQuizState();
}

class _StudentQuizState extends State<StudentQuiz> {
  Object? data;
  List<dynamic> _questionList = [];
  List<Column> widgetList = [];
  int _currentQuestion = 0;
  int? _choice = -1;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments;
    _questionList = (data as List<dynamic>);
    return Scaffold(
      appBar: createAppBar('Quiz'),
      backgroundColor: MY_BACKGROUND_COLOR,
      body: SingleChildScrollView(
        child: Padding(
          padding: myPadding,
          child: (_questionList.isEmpty) //If there are no questions in the lesson only display a message, else build the page
              ? Center(
                  child: Text(
                  'This lesson doesnt have any questions yet, come back later!',
                  style: TextStyle(color: Colors.black, fontSize: 0.05.sw),
                ))
              : Column(
                  children: [

                    //Show the current question
                    _showCurrentQuestion(),

                    SizedBox(
                      height: 0.05.sh,
                    ),

                    //Show answer button
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showAnswer();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(0.4.sw, 0.08.sh),
                            primary: const Color(0xFF000000),
                            shape: RoundedRectangleBorder(
                                borderRadius: MY_BORDER_RADIUS)),
                        child: const Center(
                          child: Text(
                            'Show Answer',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),

                    SizedBox(
                      height: 0.1.sh,
                    ),

                    //Question count
                    Text(
                      '${_currentQuestion + 1}/${_questionList.length}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    SizedBox(
                      height: 0.07.sh,
                    ),

                    //Navigation buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        createNavButton('Previous', -1),
                        SizedBox(
                          width: 0.02.sw,
                        ),
                        createNavButton('Next', 1)
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }

  //Shows the question in the current index of the list
  Column _showCurrentQuestion() {
    if (_currentQuestion >= widgetList.length) {
      widgetList.add(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 0.05.sh,
          ),
          Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80.sp),
                color: Colors.black,
              ),
              child: SizedBox(
                width: 0.8.sw,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(120.sp),
                    child: Text(
                      _questionList[_currentQuestion].question,
                      style: TextStyle(color: Colors.white, fontSize: 0.05.sw),
                      maxLines: 3,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 0.05.sh,
          ),

          //If the question is written, create a text field, else( is MCQ) create options
          (_questionList[_currentQuestion] is WrittenQuestion)
              ? createTextField(TextEditingController(), 3, 200,
                  'Enter your answer', 'Answer')
              : _createChoices(),
        ],
      ));
    }
    return widgetList[_currentQuestion];
  }

  //Create previous and next buttons
  ElevatedButton createNavButton(String s, int direction) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            if (_currentQuestion + direction < 0 ||
                _currentQuestion + direction >= _questionList.length) {}  //Do nothing if we try to decrement or increment at the edges
            else {
              _currentQuestion += direction;
            }
          });
        },
        style: ElevatedButton.styleFrom(
            fixedSize: Size(0.3.sw, 0.08.sh),
            primary: const Color(0xFF000000),
            shape: RoundedRectangleBorder(borderRadius: MY_BORDER_RADIUS)),
        child: Center(
          child: Text(
            s,
            style: const TextStyle(color: Colors.white),
          ),
        ));
  }

  //MCQ Choices
  DecoratedBox _createChoices() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: MY_BORDER_RADIUS,
      ),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                createRadio(0, _questionList[_currentQuestion].option1),
                createRadio(1, _questionList[_currentQuestion].option2)
              ],
            ),
            Column(
              children: [
                createRadio(2, _questionList[_currentQuestion].option3),
                createRadio(3, _questionList[_currentQuestion].option4),
              ],
            )
          ],
        ),
      ),
    );
  }

  //Creating radio buttons for options
  Row createRadio(int value, String text) {
    return Row(
      children: [
        Radio(
            value: value,
            groupValue: _choice,
            onChanged: (int? value) {
              setState(() {
                _choice = value;
              });
            }),
        MyText(text: text),
      ],
    );
  }

  //Popup for showing answer
  Future<void> _showAnswer() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.black,
            title: const Center(
                child: Text(
              'Answer',
              style: TextStyle(color: Colors.white),
            )),
            children: [
              Center(
                  child: Padding(
                padding:
                    EdgeInsets.fromLTRB(0.01.sw, 0.01.sh, 0.01.sw, 0.07.sh),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: MY_BORDER_RADIUS, color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: 0.5.sw,
                          child: Text(
                            _questionList[_currentQuestion].answer,
                            style: TextStyle(
                                fontSize: 0.04.sw, color: Colors.black),
                          )),
                    )),
              ))
            ],
          );
        });
  }
}
