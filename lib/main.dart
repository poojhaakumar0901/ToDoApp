import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/pages/calendar_page.dart';
import 'init/app_initializer.dart';

void main() async {
  await initializeApp(); 
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
