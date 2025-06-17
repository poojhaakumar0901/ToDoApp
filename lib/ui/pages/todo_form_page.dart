import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/todo_form_controller.dart';

class TodoFormPage extends StatelessWidget {
  final DateTime date;
  const TodoFormPage({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final formController = Get.put(TodoFormController());

    return Scaffold(
      appBar: AppBar(title: const Text("Add Todo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
          children: [
            TextField(
              onChanged: formController.setNotes,
              decoration: const InputDecoration(labelText: 'Notes'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: formController.pickImage,
              icon: const Icon(Icons.image),
              label: Text(formController.imagePath.value.isEmpty
                  ? "Attach Image (optional)"
                  : "Image Attached"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => formController.submit(date),
              child: const Text("Save"),
            )
          ],
        )),
      ),
    );
  }
}
