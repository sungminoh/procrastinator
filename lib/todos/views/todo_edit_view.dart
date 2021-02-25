import 'package:flutter/material.dart';
import 'package:my_app/common/compoments/floatting_modal.dart';
import 'package:my_app/common/constants.dart';
import 'package:my_app/common/locator.dart';
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
    if (widget.todo.content?.isNotEmpty || false) {
      getIt<TodoList>().update(widget.todo);
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.todo.content != null) {
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
          ],
        )
    );
  }
}


