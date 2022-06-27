import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_psychologist/providers/user_provider.dart';
import 'package:digital_psychologist/screens/comments_screen.dart';
import 'package:flutter/material.dart';
import 'package:digital_psychologist/resources/firestore_methods.dart';
import 'package:digital_psychologist/utils/colors.dart';
import 'package:digital_psychologist/utils/global_variable.dart';
import 'package:digital_psychologist/utils/utils.dart';
import 'package:digital_psychologist/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class ScoreCard extends StatefulWidget {
  final snap;
  const ScoreCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  @override
  void initState() {
    super.initState();
  }

  deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 5.0,
            percent: (widget.snap['totalScore']) / 100,
            center: new Text(widget.snap['totalScore'].toString() + '%'),
            progressColor: Colors.blueAccent,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${widget.snap['publishedDate']}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Stress:' + widget.snap['stress'].toString(),
                          style: TextStyle(fontSize: 16, height: 1.5),
                        ),
                        Text(
                          'Anxiety:' + widget.snap['anxiety'].toString(),
                          style: TextStyle(fontSize: 16, height: 1.5),
                        ),
                        Text(
                          'Insomnia:' + widget.snap['insomnia'].toString(),
                          style: TextStyle(fontSize: 16, height: 1.5),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Depression:' + widget.snap['depression'].toString(),
                          style: TextStyle(fontSize: 16, height: 1.5),
                        ),
                        Text(
                          'Overwhelm:' + widget.snap['overwhelm'].toString(),
                          style: TextStyle(fontSize: 16, height: 1.5),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
