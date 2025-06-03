import 'package:objectbox/objectbox.dart';

@Entity()
class Todo {
  int id = 0;
  String notes;
  bool status;
  DateTime date;
  String? imagePath;

  Todo({required this.notes, required this.date, this.status = false,this.imagePath});
}
