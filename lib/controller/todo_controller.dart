import 'package:get/get.dart';
import '../database/objectbox_helper.dart';
import '../models/todo.dart';

class TodoController extends GetxController {
  final ObjectBoxHelper db;
  RxList<Todo> todos = <Todo>[].obs;

  TodoController(this.db);

  void loadTodosForDate(DateTime date) {
    todos.value = db.getTodosByDate(date);
  }

  void addTodo(Todo todo) {
    db.addTodo(todo);
    loadTodosForDate(todo.date);
  }

  void deleteTodo(int id, DateTime date) {
    db.deleteTodo(id);
    loadTodosForDate(date);
  }
}
