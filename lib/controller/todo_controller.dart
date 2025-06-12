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

  void updateTodo(Todo todo) {
    repository.updateTodo(todo);
    int index = todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      todos[index] = todo; 
      todos.refresh(); 
    }
  }
}
