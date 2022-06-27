import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_psychologist/providers/user_provider.dart';
import 'package:digital_psychologist/screens/comments_screen.dart';
import 'package:flutter/material.dart';
import 'package:digital_psychologist/models/user.dart' as model;
import 'package:digital_psychologist/resources/firestore_methods.dart';
import 'package:digital_psychologist/utils/colors.dart';
import 'package:digital_psychologist/utils/global_variable.dart';
import 'package:digital_psychologist/utils/utils.dart';
import 'package:digital_psychologist/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class JournalCard extends StatefulWidget {
  final snap;
  const JournalCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<JournalCard> createState() => _JournalCardState();
}

class _JournalCardState extends State<JournalCard> {
  @override
  void initState() {
    super.initState();
  }

  deleteJournal(String journalId) async {
    try {
      await FireStoreMethods().deleteJournal(journalId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;

    return Container(
      // boundary needed for web
      decoration: BoxDecoration(
        border: Border.all(
          color: secondaryColor,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          // IMAGE SECTION OF THE POST
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              widget.snap['postUrl'].toString(),
              fit: BoxFit.cover,
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: ' ${widget.snap['description']}',
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          DateFormat.yMMMd()
                              .format(widget.snap['datePublished'].toDate()),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            children: [
                              'Delete',
                            ]
                                .map(
                                  (e) => InkWell(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        child: Text(e),
                                      ),
                                      onTap: () {
                                        deleteJournal(
                                          widget.snap['journalId'].toString(),
                                        );
                                        // remove the dialog box
                                        Navigator.of(context).pop();
                                      }),
                                )
                                .toList()),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.more_vert),
              )
            ],
          )
        ],
      ),
    );
  }
}
