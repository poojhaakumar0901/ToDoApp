import 'package:flutter/material.dart';
import 'package:todo_app/home.dart';
import 'objectbox_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initObjectBox();
  runApp(const MyApp());
}
