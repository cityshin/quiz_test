import 'package:flutter/material.dart';
import 'package:quiz_app_test/model/model_quiz.dart';
import 'package:quiz_app_test/screen/screen_home.dart';

class ResultScreen extends StatelessWidget {
  List<int> answers;
  List<Quiz> quizs;

  ResultScreen({super.key, required this.answers, required this.quizs});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    int score = 0;
    for (int i = 0; i < quizs.length; i++) {
      if (quizs[i].answer == answers[i]+1) {
        score += 1;
      }
    }

    return WillPopScope(
      onWillPop: () async =>false,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text('MY QUIZ APP'),
          backgroundColor: Colors.deepPurple,
          leading: Container(),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.deepPurple),
              color: Colors.deepPurple,
            ),
            width: width * 0.85,
            height: height * 0.5,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: width * 0.048),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.deepPurple),
                      color: Colors.white),
                  width: width * 0.73,
                  height: height * 0.40,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            0, width * 0.048, 0, width * 0.012),
                        child: Text(
                          '수고!',
                          style: TextStyle(
                            fontSize: width * 0.055,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'your score',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: width * 0.048),
                      ),
                      Expanded(child: Container()),
                      Text(
                        '$score/${quizs.length}',
                        style: TextStyle(
                            fontSize: width * 0.21,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      Padding(padding: EdgeInsets.all(width * 0.012)),
                      Expanded(child: Container()),
                      Container(
                        padding: EdgeInsets.only(bottom: width * 0.048),
                        child: ButtonTheme(
                          minWidth: width * 0.73,
                          height: height * 0.05,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomeScreen();
                              }));
                            },
                            child: Text(
                              'Home',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
