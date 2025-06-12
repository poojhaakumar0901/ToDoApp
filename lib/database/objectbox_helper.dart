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
    return todoBox
        .query(Todo_.date.equals(date.millisecondsSinceEpoch))
        .build()
        .find();
  }
}
