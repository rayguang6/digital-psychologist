import 'package:digital_psychologist/models/task_data.dart';
import 'package:digital_psychologist/providers/todo_provider.dart';
import 'package:digital_psychologist/providers/user_provider.dart';
import 'package:digital_psychologist/responsive/mobile_screen_layout.dart';
import 'package:digital_psychologist/responsive/responsive_layout.dart';
import 'package:digital_psychologist/responsive/web_screen_layout.dart';
import 'package:digital_psychologist/screens/login_screen.dart';
import 'package:digital_psychologist/utils/colors.dart';
import 'package:digital_psychologist/utils/global_variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    sharedPreferences = await SharedPreferences.getInstance();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAKnAgFZfcMj88U_Bh5J3im573KC5eJRgI",
        appId: "1:980762086588:web:ca117e654e8b93119a94b9",
        messagingSenderId: "980762086588",
        projectId: "digital-psychology",
        storageBucket: "digital-psychology.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
    sharedPreferences = await SharedPreferences.getInstance();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskData(),
        ),
        ChangeNotifierProvider(
          create: (_) => TodosProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Digital Psychologist',
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
