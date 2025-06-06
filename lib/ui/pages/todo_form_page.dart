import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/todo_controller.dart';
import '../../models/todo.dart';

class TodoFormPage extends StatefulWidget {
  final DateTime date;
  const TodoFormPage({super.key, required this.date});

  @override
  State<TodoFormPage> createState() => _TodoFormPageState();
}

class _TodoFormPageState extends State<TodoFormPage> {
  final _notesController = TextEditingController();
  String? _imagePath;
  final controller = Get.find<TodoController>();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => _imagePath = image.path);
  }

  void _submit() {
    if (_notesController.text.isEmpty) return;

    final todo = Todo(
      notes: _notesController.text,
      date: widget.date,
      imagePath: _imagePath,
    );                                                
    controller.addTodo(todo);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Todo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _notesController, decoration: const InputDecoration(labelText: 'Notes')),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Attach Image (optional)"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _submit,
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
