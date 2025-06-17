import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../controller/todo_controller.dart';
import 'todo_form_page.dart';
import 'todo_detail_page.dart';
import '../widgets/todo_tile.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDate = DateTime.now();
  final controller = Get.find<TodoController>();

  @override
  void initState() {
    super.initState();
    controller.loadTodosForDate(selectedDate);
  }

  void onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() => selectedDate = day);
    controller.loadTodosForDate(day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ToDo Calendar')),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: selectedDate,
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.utc(2100),
            calendarFormat: CalendarFormat.week,
            selectedDayPredicate: (day) => isSameDay(day, selectedDate),
            onDaySelected: onDaySelected,
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.todos.length,
                itemBuilder: (_, i) {
                  final todo = controller.todos[i];
                  return TodoTile(
                    todo: todo,
                    onTap: () => Get.to(() => TodoDetailPage(todo: todo)),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => TodoFormPage(date: selectedDate)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
