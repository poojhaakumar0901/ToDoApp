import '../models/todo.dart';
import '../objectbox.g.dart';

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

  Box<Todo> get box => todoBox;
}
