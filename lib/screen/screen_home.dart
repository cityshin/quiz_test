import 'package:flutter/material.dart';
import 'package:quiz_app_test/model/api_adapter.dart';
import 'package:quiz_app_test/model/model_quiz.dart';
import 'package:quiz_app_test/screen/screen_quiz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Quiz> quizs = [];
  bool isLoading = false;

  _fetchQuizs() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Uri.parse('https://shin-quiz-test.herokuapp.com/quiz/3/'));
    if (response.statusCode == 200) {
      setState(() {
        quizs = parseQuizs(utf8.decode(response.bodyBytes));
        isLoading = false;
      });
    } else {
      throw Exception('failed to load data');
    }
  }

/*List<Quiz> quizs = [
  Quiz.fromMap({
    'title' : 'test',
    'candidates' : ['a','b','c','d'],
    'answer' : 0
  }),
  Quiz.fromMap({
    'title' : 'test',
    'candidates' : ['a','b','c','d'],
    'answer' : 0
  }),
  Quiz.fromMap({
    'title' : 'test',
    'candidates' : ['a','b','c','d'],
    'answer' : 0
  }),
]; */

  @override
  Widget build(BuildContext context) {
    //기기에 맞춰 사이즈 정하기
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
          //노란색 바 생김 방지
          child: Scaffold(
            key: _scaffoldKey,
        appBar: AppBar(
          title: Text('My Quiz App'),
          backgroundColor: Colors.deepPurple,
          leading: Container(), //뒤로가기 버튼 지움
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                'images/quiz.png',
                width: width * 0.8,
              ),
            ),
            Padding(padding: EdgeInsets.all(width * 0.024)),
            Text(
              '플러터 퀴즈 앱',
              style: TextStyle(
                  fontSize: width * 0.065, fontWeight: FontWeight.bold),
            ),
            const Text(
              '퀴즈를 풀기 전 안내사항입니다.\n읽고 퀴즈 풀기를 읽어주세요',
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.all(width * 0.048)),
            _buildStep(width, '1. 랜덤 3개'),
            _buildStep(width, '2. 운동 관련'),
            _buildStep(width, '3. 화이팅!'),
            Padding(padding: EdgeInsets.all(width * 0.048)),
            Container(
              padding: EdgeInsets.only(bottom: width * 0.036),
              child: Center(
                  child: ButtonTheme(
                minWidth: width * 0.8,
                height: height * 0.05,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  onPressed: () {

                    _fetchQuizs().whenComplete(() {
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizScreen(quizs: quizs)));
                    });
                  },
                  child: Text(
                    '지금 풀기',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
            )
          ],
        ),
      )),
    );
  }

  Widget _buildStep(double width, String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          width * 0.048, width * 0.024, width * 0.048, width * 0.024),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_box,
            size: width * 0.04,
          ),
          Padding(padding: EdgeInsets.only(right: width * 0.024)),
          Text(title)
        ],
      ),
    );
  }
}
