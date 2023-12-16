import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/controllers/TodoController.dart';
import 'package:todo/constants.dart';
import 'package:todo/controllers/baseController.dart';
import 'package:todo/views/todo_list_page.dart';

void main() async {
  await GetStorage.init();
  Get.put(BaseController());
  Get.put(TodoController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo App',
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Constants.orange)),
      debugShowCheckedModeBanner: false,
      home: const TodoListPage(),
    );
  }
}
