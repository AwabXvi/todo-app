
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/constants.dart';
import 'package:todo/controllers/baseController.dart';
import 'package:todo/models/TodoModel.dart';
import 'package:todo/network/api.dart';
import 'package:todo/utill/utill.dart';

class TodoController extends GetxController {
  var todos = <dynamic>[].obs;
  var filteredTodos = <dynamic>[].obs; // Added for search functionality
  final box = GetStorage();
  final TextEditingController searchController = TextEditingController(); // Controller for search input
  @override
  void onInit() async {
    super.onInit();
    await fetchTasks();
    searchController.addListener(() {
      filterTodos();
    });
  }


  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  Future<void> fetchTasks() async {
    if(await checkConnectivity()){
      final response = await Api.getTaskList();
      Utils.processResponse(
          response: response,
          onCompleted: (data) {
            /// save the data locally to be used if there is no internet
            box.write('todos', data);
            ///parse json if it's completed
            todos.assignAll(data.map((e) => TodoModel.fromJson(e)).toList());
            filteredTodos.assignAll(todos);
          },

          /// Handle Exceptions here
          onError: () =>  false);
    }
    else{
      if (box.read('todos') !=null) {
        final List<dynamic> storedData = box.read<List>('todos')!;
        todos.assignAll(storedData.map((e) => TodoModel.fromJson(e)).toList());
        filteredTodos.assignAll(todos);

      }
      else{
        final BaseController baseController = Get.find();
        baseController.isLoading.value = true;
        Get.snackbar('No Internet', 'There is no internet connection please check your internet',snackPosition:SnackPosition.BOTTOM,snackStyle: SnackStyle.FLOATING,backgroundColor: Constants.sweetRed,colorText: Colors.white);

      }
    }
  }
  void filterTodos() {
    final String query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      /// show all todos If the search query is empty
      filteredTodos.assignAll(todos);
    } else {
      /// Filter todos
      filteredTodos.assignAll(todos.where((todo) => todo.title.toLowerCase().startsWith(query)).toList());
    }
  }

  Future<bool> addOrUpdateTask({var req, bool isEdit = false}) async {
    final response = await Api.addOrUpdateTask(req: req, isEdit: isEdit);
    var result = false;
    Utils.processResponse(
        response: response,
        onCompleted: (data) {
          /// handle based on action
          if(isEdit){
            final index = todos.indexWhere((t) => t.id == data['id']);
            if (index != -1) {
              todos[index] = TodoModel.fromJson(data);
            }
          }
          else{
            todos.add(TodoModel.fromJson(data));

          }
          result = true;
        },

        /// Handle Exceptions here
        onError: () {
          result = false;
        });
    return result;
  }
  Future<bool> deleteTask({var id,}) async {
    final response = await Api.deleteTask(id: id,);
    var result = false;
    Utils.processResponse(
        response: response,
        onCompleted: (data) {
          result = true;
        },

        /// Handle Exceptions here
        onError: () {
          result = false;
        });
    return result;
  }
  Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
     return false;
    } else {
      /// Internet connection is available
      return true;

    }
  }
}

