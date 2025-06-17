import 'package:objectbox/objectbox.dart';

@Entity()
class Todo {
  @Id()
  int id;

  String notes;
  bool isCompleted;
  String? imagePath;
  DateTime date;

  Todo({
    this.id =0,
    required this.notes,
    required this.date,
    this.isCompleted = false,
    this.imagePath,
  });
}
