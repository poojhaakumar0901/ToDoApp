import '../models/todo.dart';

abstract class TodoRepository {
  Future<void> addTodo(Todo todo);
  Future<void> deleteTodo(int id);
  Todo? getTodoById(int id);
  Future<void> updateTodo(Todo todo);
  List<Todo> getTodosByDate(DateTime date);
}
