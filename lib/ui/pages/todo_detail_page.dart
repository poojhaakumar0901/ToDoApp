import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/todo.dart';

class TodoDetailPage extends StatelessWidget {
  final Todo todo;

  const TodoDetailPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ToDo Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todo.notes, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Completed: ${todo.isCompleted ? 'Yes' : 'No'}"),
            const SizedBox(height: 10),
            Text("Date: ${todo.date.toLocal().toString().split(' ')[0]}"),
            const SizedBox(height: 20),
            if (todo.imagePath != null)
              Image.file(File(todo.imagePath!), height: 200),
          ],
        ),
      ),
    );
  }
}
