import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/todo_controller.dart';
import 'database/objectbox_helper.dart';
import 'ui/pages/calendar_page.dart';

late final ObjectBoxHelper objectBoxHelper;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBoxHelper = await ObjectBoxHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDo App',
      home: Builder(
        builder: (context) {
          Get.put(TodoController(objectBoxHelper));
          return CalendarPage();
        },
      ),
    );
  }
}
