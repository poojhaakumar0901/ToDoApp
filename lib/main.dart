import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/todo_controller.dart';
import 'database/objectbox_helper.dart';
import 'database/objectbox_repo.dart';
import 'ui/pages/calendar_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final objectBoxHelper = await ObjectBoxHelper.init();

  final repository = ObjectBoxTodoRepository(objectBoxHelper);
  Get.put(TodoController(repository));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDo App',
      theme: ThemeData(primarySwatch: Colors.teal),
      debugShowCheckedModeBanner: false,
      home: const CalendarPage(),
    );
  }
}
