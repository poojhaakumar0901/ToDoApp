// lib/widgets/status_icon.dart
import 'package:flutter/material.dart';
import '../../controller/todo_controller.dart';
import '../../models/todo.dart';

class StatusToggleIcon extends StatelessWidget {
  final Todo todo;
  final TodoController controller;

  const StatusToggleIcon({
    super.key,
    required this.todo,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        todo.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
        color: todo.isCompleted ? Colors.green : null,
      ),
      onPressed: () {
        final updated = Todo(
          id: todo.id,
          notes: todo.notes,
          isCompleted: !todo.isCompleted,
          date: todo.date,
          imagePath: todo.imagePath,
        );
        controller.updateTodo(updated);
      },
    );
  }
}
