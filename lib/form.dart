import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/objectbox_helper.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class AddTodoScreen extends StatefulWidget {
  final DateTime selectedDate;
  const AddTodoScreen({super.key, required this.selectedDate});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _controller = TextEditingController();
  String? _imagePath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final dir = await getApplicationDocumentsDirectory();
    final filename = path.basename(pickedFile.path);
    final savedPath = path.join(dir.path, filename);
    

    final savedImage = await File(pickedFile.path).copy(savedPath);
    debugPrint("@@@@@@@@@@@@@@@@@@@@@@@@@Saved image path: ${savedImage.path}");

    setState(() {
      _imagePath = savedImage.path;
    });
  }

  
  void _saveTodo() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final todo = Todo(
        notes: text,
        date: widget.selectedDate,
        imagePath: _imagePath,
      );

      // 🔍 Log the image path
      if (_imagePath != null) {
        debugPrint("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Image saved at path: $_imagePath");
      } else {
        debugPrint("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&No image attached.");
      }

      todoBox.put(todo);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Note")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Date: ${DateFormat.yMMMd().format(widget.selectedDate)}"),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter note'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Attach Image"),
            ),
            if (_imagePath != null) ...[
              const SizedBox(height: 10),
              Image.file(File(_imagePath!), height: 100),
            ],
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _saveTodo, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
