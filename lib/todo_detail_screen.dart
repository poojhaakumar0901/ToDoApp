import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

class TodoDetailScreen extends StatelessWidget {
  final Todo todo;
  const TodoDetailScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final String? imagePath = todo.imagePath;
    final bool imageExists = imagePath != null && File(imagePath).existsSync();

    debugPrint("Todo image path: $imagePath");
    debugPrint("Image file exists: $imageExists");

    return Scaffold(
      appBar: AppBar(title: const Text('Todo Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.notes,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (imageExists) ...[
              const Text(
                'Attached Image:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Image.file(
                File(imagePath),
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ] else if (imagePath != null) ...[
              const SizedBox(height: 20),
              const Text(
                "Image path provided but file not found.",
                style: TextStyle(color: Colors.red),
              ),
              Text("Path: $imagePath"),
            ] else ...[
              const SizedBox(height: 20),
              const Text("No image attached."),
            ],
          ],
        ),
      ),
    );
  }
}
