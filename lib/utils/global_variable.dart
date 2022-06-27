import 'package:digital_psychologist/screens/community_screen.dart';
import 'package:digital_psychologist/screens/home_screen.dart';
import 'package:digital_psychologist/screens/journal_screen.dart';
import 'package:digital_psychologist/screens/profile_screen.dart';
import 'package:digital_psychologist/screens/score_screen.dart';
import 'package:digital_psychologist/screens/tasks_screen.dart';
import 'package:digital_psychologist/screens/todo_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const webScreenSize = 600;
SharedPreferences? sharedPreferences;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

List<Widget> homeScreenItems = [
  const HomeScreen(),
  // TasksScreen(),
  TodoScreen(),
  const JournalScreen(),
  const ScoreScreen(),
  const CommunityScreen(),
  // ProfileScreen(
  //   uid: FirebaseAuth.instance.currentUser!.uid,
  // ),
];
