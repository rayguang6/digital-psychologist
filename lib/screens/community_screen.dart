import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_psychologist/resources/firestore_methods.dart';
import 'package:digital_psychologist/screens/add_post_screen.dart';
import 'package:digital_psychologist/utils/colors.dart';
import 'package:digital_psychologist/utils/global_variable.dart';
import 'package:digital_psychologist/utils/utils.dart';
import 'package:digital_psychologist/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.post_add),
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPostScreen()),
          );
        },
      ),
      appBar: width > webScreenSize
          ? null
          : AppBar(
              centerTitle: true,
              backgroundColor: Colors.blueAccent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/white-logo.png',
                    color: Colors.white,
                    height: 32,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'DP Community',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.add_box_rounded,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddPostScreen()),
                    );
                  },
                ),
              ],
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
