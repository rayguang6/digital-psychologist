import 'package:digital_psychologist/models/task_data.dart';
import 'package:digital_psychologist/widgets/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_task_screen.dart';

class AnxietyChecklist extends StatelessWidget {
  String checklistTitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Anxiety Checklist'),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.greenAccent,
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: Colors.blueAccent,
      //     child: Icon(Icons.add),
      //     onPressed: () {
      //       showModalBottomSheet(
      //           context: context,
      //           isScrollControlled: true,
      //           builder: (context) => SingleChildScrollView(
      //                   child: Container(
      //                 padding: EdgeInsets.only(
      //                     bottom: MediaQuery.of(context).viewInsets.bottom),
      //                 child: AddTaskScreen(),
      //               )));
      //     }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                CircleAvatar(
                  child: Icon(
                    Icons.list,
                    size: 30.0,
                    color: Colors.lightGreenAccent,
                  ),
                  backgroundColor: Colors.white,
                  radius: 30.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Anxiety Checklist',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // Text(
                //   '${Provider.of<TaskData>(context).taskCount} Steps',
                //   style: const TextStyle(
                //     color: Colors.white,
                //     fontSize: 18,
                //   ),
                // ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: TasksList(),
            ),
          ),
        ],
      ),
    );
  }
}
