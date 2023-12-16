import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/TodoController.dart';
import 'package:todo/constants.dart';
import 'package:todo/models/TodoModel.dart';
import 'package:todo/widgets/Insets.dart';
import 'package:todo/widgets/base_template.dart';
import 'package:todo/widgets/spacers.dart';
import 'package:todo/widgets/text_form_field.dart';
import 'package:todo/widgets/txt.dart';

import 'add_or_edit_todo.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({
    super.key,
  });

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  TodoController todoController =
      Get.find(); // Rather Controller controller = Controller();
  final FocusNode _focusSearch = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await goToAddOrUpdateTask();
        },
        backgroundColor: Constants.orange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Txt.largeTxt('Todo List'),
          VSpacer.spaceSmall(),
          InputWidget(
            textStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                color: Constants.blackTxtColor,
                fontWeight: FontWeight.bold,
                fontFamily: Constants.fontFamily),
            focusNode: _focusSearch,
            onChange: (text){

            },
            lableTxt: "Search Task",
            contentPadding: const EdgeInsets.fromLTRB(15, 18, 35, 18),
            controller: todoController.searchController,
            textInputType: TextInputType.text,
          ),
          VSpacer.spaceMedium(),
          buildTaskListView()
        ],
      ),
    );
  }

  ///This will build the task list
  Widget buildTaskListView() {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) =>
            buildTaskTile(todoController.filteredTodos[index]),
        separatorBuilder: (context, itemIndex) => VSpacer.spaceSmall(),
        itemCount: todoController.filteredTodos.length,
      ),
    );
  }

  ///This will build the task tile
  Widget buildTaskTile(TodoModel todo) {
    return BounceInUp(
      duration: const Duration(milliseconds: 1800),
      child: GestureDetector(
        onTap: () async {
          await goToAddOrUpdateTask(todo: todo);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.spacingTiny,
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Insets.spacingTiny),
                border: Border.all(color: Constants.grey_20, width: 1.3)),
            padding:
                const EdgeInsets.symmetric(vertical: Insets.spacingStandard),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                    activeColor: Constants.orange,
                    side: BorderSide(color: Constants.grey_20, width: 1.3),
                    value: todo.completed,
                    onChanged: (v) async {
                      setState(() {
                        todo.completed = v;
                      });
                      var req = {
                        'id': todo.id,
                        'title': todo.title,
                        'completed': v
                      };
                      await todoController.addOrUpdateTask(
                          req: req, isEdit: true);
                    }),
                Expanded(child: Txt.mediumTxt('${todo.title}')),
                statusText(todo),
                HSpacer.spaceSmall(),
                buildDeleteButton(todo),
                HSpacer.spaceSmall(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector buildDeleteButton(TodoModel todo) {
    return GestureDetector(
      onTap: () async {
        var rs = await todoController.deleteTask(id: todo.id);
        if (rs) todoController.todos.remove(todo);
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Constants.sweetRed,
            borderRadius: BorderRadius.circular(Insets.spacingTiny)),
        padding: const EdgeInsets.all(6),
        child: const Icon(
          Icons.delete_outline_outlined,
          color: Colors.white,
          size: IconSizes.iconSmall,
        ),
      ),
    );
  }

  ///Status widget
  Widget statusText(TodoModel todo) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Insets.spacingTiny),
            color: Constants.greenLight,
            border: Border.all(color: Constants.grey_20, width: 1.3)),
        padding: const EdgeInsets.all(6),
        child: Txt.tinyTxt(
            todo.completed ?? false ? 'Completed' : 'In Progress',
            color: Colors.white),
      );

  Future<dynamic> goToAddOrUpdateTask({var todo}) async {
    await Get.to(() => AddOrEditTodo(todo: todo),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 100));
  }
}
