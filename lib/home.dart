import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/form.dart';
import 'package:todo_app/objectbox.g.dart';
import 'package:todo_app/todo_detail_screen.dart';
import 'models/todo.dart';
import 'objectbox_helper.dart';
import 'package:intl/intl.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CalendarScreen());
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  List<Todo> _getTodosForDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return todoBox
        .query(
          Todo_.date
              .greaterOrEqual(start.millisecondsSinceEpoch)
              .and(Todo_.date.lessThan(end.millisecondsSinceEpoch)),
        )
        .build()
        .find();
  }

  @override
  Widget build(BuildContext context) {
    final todos = _getTodosForDay(_selectedDay);

    return Scaffold(
      appBar: AppBar(title: const Text("Calendar ToDo App")),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.utc(2100),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddTodoScreen(selectedDate: _selectedDay),
                ),
              ).then((_) => setState(() {})); // Refresh when coming back
            },
            child: Text(
              'Add Note for ${DateFormat.yMMMd().format(_selectedDay)}',
            ),
          ),
          const Divider(),
          const Text('Notes:'),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (_, i) {
                final todo = todos[i];
                return ListTile(
                  title: Text(todo.notes),
                  trailing: Checkbox(
                    value: todo.status,
                    onChanged: (val) {
                      todo.status = val ?? false;
                      todoBox.put(todo);
                      setState(() {});
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TodoDetailScreen(todo: todo),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}