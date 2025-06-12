import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../controller/todo_controller.dart';
import '../database/objectbox_helper.dart';
import '../repository/objectbox_repo.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  final objectBoxHelper = await ObjectBoxHelper.init();
  final repository = ObjectBoxTodoRepository(objectBoxHelper);

  Get.put(TodoController(repository));
}
