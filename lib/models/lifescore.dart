import 'package:cloud_firestore/cloud_firestore.dart';

class Lifescore {
  String? lifescoreID;
  String? uid;
  Timestamp? publishedDate;
  int depressionScore = 0;
  int anxietyScore = 0;
  int insomniaScore = 0;
  int stressScore = 0;
  int overwhelmScore = 0;
  int totalScore = 0;

  Lifescore(
      this.lifescoreID,
      this.uid,
      this.publishedDate,
      this.depressionScore,
      this.anxietyScore,
      this.insomniaScore,
      this.stressScore,
      this.overwhelmScore,
      this.totalScore);

  Lifescore.fromJson(Map<String, dynamic> json) {
    lifescoreID = json["lifescoreID"];
    uid = json['uid'];
    publishedDate = json['publishedDate'];
    depressionScore = json['depressionScore'];
    anxietyScore = json['anxietyScore'];
    insomniaScore = json['insomniaScore'];
    stressScore = json['stressScore'];
    overwhelmScore = json['overwhelmScore'];
    totalScore = json['totalScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["lifescoreID"] = lifescoreID;
    data['uid'] = uid;
    data['publishedDate'] = publishedDate;
    data['depressionScore'] = depressionScore;
    data['anxietyScore'] = anxietyScore;
    data['insomniaScore'] = insomniaScore;
    data['stressScore'] = stressScore;
    data['overwhelmScore'] = overwhelmScore;
    data['totalScore'] = totalScore;

    return data;
  }
}
