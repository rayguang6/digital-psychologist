import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_psychologist/models/todo.dart';
import 'package:digital_psychologist/utils/global_variable.dart';
import 'package:digital_psychologist/utils/my_utils.dart';

class FirebaseApi {
  static Future<String> createTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences!.getString("uid"))
        .collection("todo")
        .doc();

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  static Stream<List<Todo>> readTodos() => FirebaseFirestore.instance
      .collection('users')
      .doc(sharedPreferences!.getString("uid"))
      .collection("todo")
      .orderBy(TodoField.createdTime, descending: true)
      .snapshots()
      .transform(MyUtils.transformer(Todo.fromJson));

  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences!.getString("uid"))
        .collection("todo")
        .doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences!.getString("uid"))
        .collection("todo")
        .doc(todo.id);

    await docTodo.delete();
  }
}
