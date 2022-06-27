import 'package:cloud_firestore/cloud_firestore.dart';

class Journal {
  final String description;
  final String uid;
  final String username;
  final String journalId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;

  const Journal({
    required this.description,
    required this.uid,
    required this.username,
    required this.journalId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
  });

  static Journal fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Journal(
        description: snapshot["description"],
        uid: snapshot["uid"],
        journalId: snapshot["journalId"],
        datePublished: snapshot["datePublished"],
        username: snapshot["username"],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['profImage']);
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "journalId": journalId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'profImage': profImage
      };
}
