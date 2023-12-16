import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/constants.dart';
import 'package:todo/controllers/TodoController.dart';
import 'package:todo/models/TodoModel.dart';
import 'package:todo/widgets/Insets.dart';
import 'package:todo/widgets/base_template.dart';
import 'package:todo/widgets/custom_btn.dart';
import 'package:todo/widgets/spacers.dart';
import 'package:todo/widgets/txt.dart';

import '../widgets/text_form_field.dart';

//ignore:must_be_immutable
class AddOrEditTodo extends StatefulWidget {
  AddOrEditTodo({super.key, this.todo});

  TodoModel? todo;

  @override
  State<AddOrEditTodo> createState() => _AddOrEditTodoState();
}

class _AddOrEditTodoState extends State<AddOrEditTodo> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final FocusNode _focusTitle = FocusNode();
  var isCompleted = false;
  final TodoController todoController = Get.find();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          isCompleted = widget.todo?.completed ?? false;
          titleController.text = widget.todo?.title ?? '';
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focusTitle.dispose();
    titleController.dispose();
    todoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
        enableBack: true,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: InputWidget(
                    textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        color: Constants.blackTxtColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: Constants.fontFamily),
                    focusNode: _focusTitle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter task title";
                      } else if (value.length < 2) {
                        return "Task title is too short";
                      }
                      return null;
                    },
                    lableTxt: "Task Title",
                    contentPadding: const EdgeInsets.fromLTRB(5, 18, 35, 18),
                    hint: 'Enter Task title',
                    controller: titleController,
                    textInputType: TextInputType.text,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Txt.mediumTxt('Is the Task Completed'),
                  Checkbox(
                      activeColor: Constants.orange,
                      side: BorderSide(color: Constants.grey_20, width: 1.3),
                      value: isCompleted,
                      onChanged: (v) {
                        setState(() {
                          isCompleted = v!;
                        });
                      }),
                ],
              ),
              VSpacer.spaceMedium(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Insets.spacingLarge + 8),
                child: CustomBtn(
                    onPressed: () async {
                      await addOrUpdateTask();
                    },
                    color: Constants.orange,
                    radius: 12,
                    child: Txt.mediumTxt(
                        widget.todo == null ? 'Add Task' : 'Update Task',
                        color: Colors.white)),
              )
            ],
          ),
        ));
  }

  Future<dynamic> addOrUpdateTask() async {
    if (_formKey.currentState!.validate()) {
      var req = {
        if (widget.todo != null) 'id': widget.todo?.id,
        'title': titleController.text,
        'completed': isCompleted
      };
      var rs = await todoController.addOrUpdateTask(
          req: req, isEdit: widget.todo != null);
      if (rs) {
        Get.back();
      } else {
        _focusTitle.unfocus();
      }
    }
  }
}
