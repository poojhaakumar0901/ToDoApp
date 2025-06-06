import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/todo.dart';
import '../../controller/todo_controller.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final VoidCallback onTap;

  const TodoTile({super.key, required this.todo, required this.onTap});

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
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text('Do you want to delete this task?'),
            actions: [
              TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
              TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Delete')),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        controller.deleteTodo(todo.id, todo.date);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Todo deleted')),
        );
      },
      child: ListTile(
        title: Text(todo.notes, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(todo.date.toLocal().toString().split(' ')[0]),
        trailing: IconButton(
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
            controller.addTodo(updated);
          },
        ),
        onTap: onTap,
      ),
    );
  }
}
