import '../models/todo.dart';

abstract class TodoRepository {
  List<Todo> getTodosByDate(DateTime date);
  void addTodo(Todo todo);
  void deleteTodo(int id);
  Todo? getTodoById(int id);
  void updateTodo(Todo todo);
}
