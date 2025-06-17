import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool?> showConfirmDeleteDialog() {
  return Get.dialog<bool>(
    AlertDialog(
      title: const Text('Confirm Delete'),
      content: const Text('Do you want to delete this task?'),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Get.back(result: true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}
