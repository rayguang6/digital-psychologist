import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_psychologist/screens/score_history.dart';
import 'package:digital_psychologist/utils/colors.dart';
import 'package:digital_psychologist/utils/global_variable.dart';
import 'package:digital_psychologist/widgets/post_card.dart';
import 'package:digital_psychologist/widgets/quiz.dart';
import 'package:digital_psychologist/widgets/result.dart';
import 'package:digital_psychologist/widgets/score_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  String todayDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  bool isScored = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkScoredOrNot();
  }

  final ref = FirebaseFirestore.instance
      .collection("users")
      .doc(sharedPreferences!.getString("uid"))
      .collection("lifescores");
  final _questionsList = [
    {
      'questionText': 'How Well You Manage Depression Today?',
      'answers': [
        {'text': '1', 'score': 4},
        {'text': '2', 'score': 8},
        {'text': '3', 'score': 12},
        {'text': '4', 'score': 16},
        {'text': '5', 'score': 20},
      ],
    },
    {
      'questionText': 'How Great Did You Handle Anxiety Today',
      'answers': [
        {'text': '1', 'score': 4},
        {'text': '2', 'score': 8},
        {'text': '3', 'score': 12},
        {'text': '4', 'score': 16},
        {'text': '5', 'score': 20},
      ],
    },
    {
      'questionText': 'I sleep well last night and for a solid 7-8 hours',
      'answers': [
        {'text': '1', 'score': 4},
        {'text': '2', 'score': 8},
        {'text': '3', 'score': 12},
        {'text': '4', 'score': 16},
        {'text': '5', 'score': 20},
      ],
    },
    {
      'questionText': 'How Well You Manage Stress Today?',
      'answers': [
        {'text': '1', 'score': 4},
        {'text': '2', 'score': 8},
        {'text': '3', 'score': 12},
        {'text': '4', 'score': 16},
        {'text': '5', 'score': 20},
      ],
    },
    {
      'questionText': 'Do You Get Overwhelmed Today',
      'answers': [
        {'text': '1', 'score': 4},
        {'text': '2', 'score': 8},
        {'text': '3', 'score': 12},
        {'text': '4', 'score': 16},
        {'text': '5', 'score': 20},
      ],
    },
  ];
  var _questionIndex = 0;
  int _totalScore = 0;
  int dScore = 0;
  int aScore = 0;
  int iScore = 0;
  int sScore = 0;
  int oScore = 0;
  late List scoreList = [];

  void _answerQuestion(int score) {
    _totalScore += score;
    scoreList.add(score);

    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    if (_questionIndex < _questionsList.length) {
      //continue to answer question
    } else {
      setState(() {
        print("answer question"
            "0: ${scoreList[0] * 5}"
            "1: ${scoreList[1] * 5}"
            "2: ${scoreList[2] * 5}"
            "3: ${scoreList[3] * 5}"
            "4: ${scoreList[4] * 5}"
            "total: ${_totalScore}"
            "");
        print("\nscoore list:");
        print(scoreList);

        isScored = true;
        // dScore = scoreList[0];
        // aScore = scoreList[1];
        // iScore = scoreList[2];
        // sScore = scoreList[3];
        // oScore = scoreList[4];
        saveScoreToDatabase(scoreList[0] * 5, scoreList[1] * 5,
            scoreList[2] * 5, scoreList[3] * 5, scoreList[4] * 5, _totalScore);
        scoreList.clear();
        print(scoreList);
        checkScoredOrNot();
      });
    }
  }

  saveScoreToDatabase(d, a, i, s, o, total) {
    print("Save Score To DB"
        "d $d"
        "a $a"
        "i $i"
        "s $s"
        "o $o"
        "total $total");

    ref.doc(todayDate).set({
      "uid": sharedPreferences!.getString("uid"),
      "publishedDate": todayDate,
      "totalScore": total,
      "depression": d,
      "anxiety": a,
      "insomnia": i,
      "stress": s,
      "overwhelm": o,
    });
  }

  //check Today Scored Or Not
  checkScoredOrNot() async {
    DocumentSnapshot ds = await ref.doc(todayDate).get();
    print('id score document exist? ' + ds.exists.toString());
    setState(() {
      isScored = ds.exists;
    });

    if (ds.exists) {
      setState(() {
        dScore = ds['depression'];
        aScore = ds['anxiety'];
        iScore = ds['insomnia'];
        sScore = ds['stress'];
        oScore = ds['overwhelm'];
        _totalScore = ds['totalScore'];
        print("Get From DB\n"
            "d $dScore"
            "a: $aScore"
            "i $iScore"
            "s $sScore"
            "o $oScore"
            "_total Score $_totalScore  "
            ""
            "");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: Colors.blueAccent,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/white-logo.png',
                    color: primaryColor,
                    height: 32,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Life Scores',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),

      //if scored today : showResult
      //else: if(index<)show Quiz, else Result
      body: isScored
          ? Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Result(_totalScore, dScore, aScore, iScore, sScore, oScore),
                const SizedBox(height: 16),
                const Divider(
                  height: 1,
                  thickness: 3,
                  indent: 50.0,
                  endIndent: 50,
                  color: Colors.blueAccent,
                ),
                SizedBox(height: 16),
                const Text(
                  'You Have Scored Yourself Today! \nYou Can:',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: const Text(
                    "See Your Previous Life Score",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScoreHistory()),
                    );
                  },
                ),
                SizedBox(height: 16),
                const Text(
                  'Improve Each Areas:',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : Column(
              children: [
                const Text(
                  'Score Yourself Today And See How Well You Manage Your Life',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                Quiz(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  questions: _questionsList,
                ),
              ],
            ),
    );
  }
}
