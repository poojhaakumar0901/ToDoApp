import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/todo.dart';
import 'todo_controller.dart';

class TodoFormController extends GetxController {
  final notes = ''.obs;
  final imagePath = ''.obs;
  final picker = ImagePicker();

  void setNotes(String text) => notes.value = text;

  Future<void> pickImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) imagePath.value = image.path;
  }

  void submit(DateTime date) {
    if (notes.isEmpty) return;
    final todo = Todo(
      notes: notes.value,
      date: date,
      imagePath: imagePath.value.isEmpty ? null : imagePath.value,
    );
    Get.find<TodoController>().addTodo(todo);
    Get.back();
  }
}
