import 'package:objectbox/objectbox.dart';
import '../models/todo.dart';
import '../../objectbox.g.dart';

class ObjectBoxHelper {
  late final Store store;
  late final Box<Todo> todoBox;

  ObjectBoxHelper._create(this.store) {
    todoBox = store.box<Todo>();
  }

  static Future<ObjectBoxHelper> init() async {
    final store = await openStore();
    return ObjectBoxHelper._create(store);
  }

  List<Todo> getTodosByDate(DateTime date) {
    return todoBox.query(Todo_.date.equals(date.millisecondsSinceEpoch)).build().find();
  }

  void addTodo(Todo todo) => todoBox.put(todo);

  void deleteTodo(int id) => todoBox.remove(id);

  Todo? getTodoById(int id) => todoBox.get(id);
}
