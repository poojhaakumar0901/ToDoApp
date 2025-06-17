import '../models/todo.dart';
import '../objectbox.g.dart';
import 'todo_repo.dart';
import '../database/objectbox_helper.dart';

class ObjectBoxTodoRepository implements TodoRepository {
  final ObjectBoxHelper helper;

  ObjectBoxTodoRepository(this.helper);

  @override
  Future <void> addTodo(Todo todo) async {
    helper.todoBox.put(todo);
  }

  @override
  Future<void> deleteTodo(int id) async {
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
  Future<void> updateTodo(Todo todo) async {
    helper.todoBox.put(todo);
  }
}
