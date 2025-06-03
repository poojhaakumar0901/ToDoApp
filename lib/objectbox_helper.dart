import 'package:path_provider/path_provider.dart';
import 'package:objectbox/objectbox.dart';
import 'models/todo.dart';
import 'objectbox.g.dart';

late final Store store;
late final Box<Todo> todoBox;

Future<void> initObjectBox() async {
  final dir = await getApplicationDocumentsDirectory();
  store = await openStore(directory: '${dir.path}/objectbox');
  todoBox = store.box<Todo>();
}
