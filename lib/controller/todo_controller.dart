import 'package:get/get.dart';
import '../models/todo.dart';
import '../repository/todo_repo.dart';

class TodoController extends GetxController {
  final TodoRepository repository;
  RxList<Todo> todos = <Todo>[].obs;

  TodoController(this.repository);

  void loadTodosForDate(DateTime date) {
    todos.value = repository.getTodosByDate(date);
  }

  void addTodo(Todo todo) {
    repository.addTodo(todo);
    todos.add(todo);
  }

  void deleteTodo(int id, DateTime date) {
    repository.deleteTodo(id);
    todos.removeWhere((t) => t.id == id);
  }

  Todo? getTodoById(int id) {
    return repository.getTodoById(id);
  }

  void updateTodo(Todo updatedTodo) {
    repository.updateTodo(updatedTodo);

    todos.value =
        todos.map((t) => t.id == updatedTodo.id ? updatedTodo : t).toList();
  }

  void toggleTodoStatus(Todo todo) {
    final updated = Todo(
      id: todo.id,
      notes: todo.notes,
      isCompleted: !todo.isCompleted,
      date: todo.date,
      imagePath: todo.imagePath,
    );

    updateTodo(updated);
  }
}
