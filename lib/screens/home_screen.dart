import 'package:carousel_slider/carousel_slider.dart';
import 'package:digital_psychologist/models/task_data.dart';
import 'package:digital_psychologist/screens/Anxiety%20Checklist.dart';
import 'package:digital_psychologist/screens/confidence_checklist.dart';
import 'package:digital_psychologist/screens/tasks_screen.dart';
import 'package:digital_psychologist/utils/global_variable.dart';
import 'package:digital_psychologist/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List motivationList = [
    "images/0.png",
    "images/1.png",
    "images/2.png",
    "images/3.png",
    "images/4.png",
    "images/5.png",
    "images/6.png",
    "images/7.png",
    "images/8.png",
    "images/9.png",
  ];

  @override
  Widget build(BuildContext context) {
    String? username = sharedPreferences?.getString('username');

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          " Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 16),
            child: const Text(
              'Stay Motivated!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 350,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 1),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: motivationList.map((index) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image.asset(
                        index,
                      ));
                },
              );
            }).toList(),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: const Text(
              'Mental Performance CheckList!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => {
                  Provider.of<TaskData>(context, listen: false).deleteAllTask(),
                  Provider.of<TaskData>(context, listen: false)
                      .addTask('Winner Posture'),
                  Provider.of<TaskData>(context, listen: false)
                      .addTask('AWARENESS - Acknowledge Yourself'),
                  Provider.of<TaskData>(context, listen: false)
                      .addTask('AMBITION - Have A Big Dream'),
                  Provider.of<TaskData>(context, listen: false)
                      .addTask('ACTION - Build Momentum'),
                  Provider.of<TaskData>(context, listen: false)
                      .addTask('Skill Building'),
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => ConfidenceChecklist()))
                },
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Image.asset(
                        'images/confidence-checklist.png',
                        width: 100,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Confidence Checklist',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                                fontSize: 22,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: const Text(
                                'Step by step to get confident now',
                                style: TextStyle(fontSize: 20, height: 1.5),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => {
                  Provider.of<TaskData>(context, listen: false).deleteAllTask(),
                  Provider.of<TaskData>(context, listen: false)
                      .addTask('Get up and move!'),
                  Provider.of<TaskData>(context, listen: false)
                      .addTask('Set an intention'),
                  Provider.of<TaskData>(context, listen: false)
                      .addTask('Consume something positive'),
                  Provider.of<TaskData>(context, listen: false)
                      .addTask('Take Action'),
                  Provider.of<TaskData>(context, listen: false)
                      .addTask('Share your vulnerabilities'),
                  Provider.of<TaskData>(context, listen: false)
                      .addTask('Hang Out With Your Friends'),
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => AnxietyChecklist()))
                },
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Image.asset(
                        'images/anxiety-checklist.png',
                        width: 100,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Depression Checklist',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                                fontSize: 22,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: const Text(
                                'Get rid of depression now',
                                style: TextStyle(fontSize: 20, height: 1.5),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
