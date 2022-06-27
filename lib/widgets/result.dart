import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final int dScore;
  final int aScore;
  final int iScore;
  final int sScore;
  final int oScore;

  Result(this.resultScore, this.dScore, this.aScore, this.iScore, this.sScore,
      this.oScore);

  String get resultPhrase {
    String resultText;
    if (resultScore <= 25) {
      resultText = 'RED Light: You Need To Get Help! ';
    } else if (resultScore <= 50) {
      resultText = 'YELLOW Light: You Need To Improve!';
    } else if (resultScore <= 75) {
      resultText = 'GREEN Light: Nice! Keep it Up!';
    } else {
      resultText = 'Perfect: You Did Great Today!';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            'Your Overall Score Today: ${(resultScore).toString()}%',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 5.0,
            percent: (resultScore / 100).toDouble(),
            center: new Text((resultScore).toString() + '%'),
            progressColor: Colors.blueAccent,
          ),
          SizedBox(height: 10),
          Text('This is How Well You Have Cope Them Today:'),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.sentiment_dissatisfied_rounded),
                    Text(' Depression Management: '),
                    Text(
                      dScore.toString() + '%',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.directions_run),
                    Text(' Anxiety Management: '),
                    Text(
                      aScore.toString() + '%',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.airline_seat_flat),
                    Text(' Insomnina Management: '),
                    Text(
                      iScore.toString() + '%',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.timer),
                    Text(' Stress Management: '),
                    Text(
                      sScore.toString() + '%',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.task),
                    const Text('Overwhelm Management: '),
                    Text(
                      oScore.toString() + '%',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
