import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_psychologist/utils/colors.dart';
import 'package:digital_psychologist/utils/global_variable.dart';
import 'package:digital_psychologist/widgets/post_card.dart';
import 'package:digital_psychologist/widgets/quiz.dart';
import 'package:digital_psychologist/widgets/result.dart';
import 'package:digital_psychologist/widgets/score_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScoreHistory extends StatefulWidget {
  const ScoreHistory({Key? key}) : super(key: key);

  @override
  _ScoreHistoryState createState() => _ScoreHistoryState();
}

class _ScoreHistoryState extends State<ScoreHistory> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: width > webScreenSize
          ? null
          : AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              centerTitle: false,
              title: Row(
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(sharedPreferences!.getString("uid"))
            .collection("lifescores")
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child: ScoreCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
