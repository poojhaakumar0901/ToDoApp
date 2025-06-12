import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/todo.dart';
import '../../controller/todo_controller.dart';
import '../../utils/dialogs.dart';          
import 'status_icon.dart';    

class TodoTile extends StatelessWidget {
  final Todo todo;
  final VoidCallback onTap;

  const TodoTile({
    super.key,
    required this.todo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodoController>();

    return Dismissible(
      key: Key(todo.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (_) => showConfirmDeleteDialog(),
      onDismissed: (_) {
        controller.deleteTodo(todo.id, todo.date);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Todo deleted')),
        );
      },
      child: ListTile(
        title: Text(
          todo.notes,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(DateFormat('dd MMM yyyy').format(todo.date)),
        trailing: StatusToggleIcon(todo: todo, controller: controller),
        onTap: onTap,
      ),
    );
  }
}
