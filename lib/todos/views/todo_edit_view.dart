import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/common/compoments/floatting_modal.dart';
import 'package:my_app/common/constants.dart';
import 'package:my_app/common/locator.dart';
import 'package:my_app/common/utils.dart';
import 'package:my_app/todos/components/scheduler.dart';
import 'package:my_app/todos/stores/todo_list_store.dart';
import 'package:my_app/todos/stores/todo_store.dart';

/**
 * todo_edit_view
 * @author sungminoh (smoh10@coupang.com)
 * @since 2/13/21.
 */
class TodoEditView extends StatefulWidget {
  final Todo todo;

  TodoEditView([
    Todo todo,
  ]): this.todo = todo ?? Todo();

  @override
  _TodoEditViewState createState() => _TodoEditViewState();
}

class _TodoEditViewState extends State<TodoEditView> {
  // final _formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    if (!widget.todo.isEmpty) {
      getIt<TodoList>().update(widget.todo);
    }
    super.dispose();
    this.textController.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.todo.content?.isNotEmpty || true) {
      this.textController.value = TextEditingValue(
          text: widget.todo.content
      );
    }
    this.textController.addListener(() {
      widget.todo.content = this.textController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final todos = Provider.of<TodoList>(context).todos;
    return Scaffold(
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 60),
                if (widget.todo.imagePath != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: 80.0,
                      height: 95.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                          image: FileImage(widget.todo.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    autofocus: true,
                    decoration: InputDecoration.collapsed(
                      hintText: Constants.TODO_NOTE_PLACEHOLDER,
                    ),
                    // onSaved: (value) => widget.todo.content = value
                  ),
                ),
              ],
            )
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
              // tooltip: Constants.RESCHEDULE_TODO_BUTTON_TOOLTIP,
              onPressed: () {
                showFloatingModalBottomSheet(
                  context: context,
                  builder: (context) => SizedBox(
                    height: 400,
                    child: Scheduler(
                      baseDateTime: widget.todo.dateTime,
                      onDispose: (dateTime) => widget.todo.dateTime = dateTime,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.watch_later),
            ),
            IconButton(
              icon: Icon(Icons.photo_camera),
              color: Colors.black,
              onPressed: () {
                getImage(ImageSource.camera).then((file) => widget.todo.imagePath = file.path);
              },
            ),
            IconButton(
              icon: Icon(Icons.insert_photo),
              color: Colors.black,
              onPressed: () {
                getImage(ImageSource.gallery).then((file) => widget.todo.imagePath = file.path);
              },
            ),
          ],
        )
    );
  }
}


