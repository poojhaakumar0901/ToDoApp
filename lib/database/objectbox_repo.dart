import '../models/todo.dart';
import '../objectbox.g.dart';
import '../repository/todo_repo.dart';
import 'objectbox_helper.dart';

class ObjectBoxTodoRepository implements TodoRepository {
  final ObjectBoxHelper helper;

  ObjectBoxTodoRepository(this.helper);

  @override
  void addTodo(Todo todo) {
    helper.todoBox.put(todo);
  }

  @override
  void deleteTodo(int id) {
    helper.todoBox.remove(id);
  }

  @override
  List<Todo> getTodosByDate(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(Duration(days: 1));

    return helper.todoBox
        .query(
          Todo_.date
              .greaterOrEqual(start.millisecondsSinceEpoch)
              .and(Todo_.date.lessThan(end.millisecondsSinceEpoch)),
        )
        .build()
        .find();
  }

  @override
  Todo? getTodoById(int id) {
    return helper.todoBox.get(id);
  }

  @override
  void updateTodo(Todo todo) {
    helper.todoBox.put(todo);
  }
}
