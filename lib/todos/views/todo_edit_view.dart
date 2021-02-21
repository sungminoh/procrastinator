import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_app/common/compoments/floatting_modal.dart';
import 'package:my_app/common/compoments/grid_buttons.dart';
import 'package:my_app/common/constants.dart';
import 'package:my_app/common/locator.dart';
import 'package:my_app/todos/stores/todo_list_store.dart';
import 'package:my_app/todos/stores/todo_store.dart';

/**
 * todo_edit_view
 * @author sungminoh (smoh10@coupang.com)
 * @since 2/13/21.
 */
class TodoEditView extends StatefulWidget {
  final TodoStore todo;

  TodoEditView({
    TodoStore todo,
  }): this.todo = todo ?? TodoStore();

  @override
  _TodoEditViewState createState() => _TodoEditViewState();
}

class _TodoEditViewState extends State<TodoEditView> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final todos = Provider.of<TodoListStore>(context).todos;
    return Scaffold(
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.headline,
                    initialValue: widget.todo.title,
                    decoration: InputDecoration(
                      hintText: Constants.TODO_TITLE_PLACEHOLDER,
                    ),
                    onSaved: (value) => widget.todo.title = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    initialValue: widget.todo.note,
                    decoration: InputDecoration(
                      hintText: Constants.TODO_NOTE_PLACEHOLDER,
                    ),
                    onSaved: (value) => widget.todo.note = value,
                  ),
                ),
              ],
            ),
          )
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: Constants.RESCHEDULE_TODO_BUTTON_TOOLTIP,
            onPressed: () {
              showFloatingModalBottomSheet(
                context: context,
                builder: (context) => SizedBox(
                  height: 400,
                    child: GridButtons(
                      children: [
                      [Icon(Icons.watch_later), Icon(Icons.watch_later), Icon(Icons.watch_later)],
                      [Icon(Icons.watch_later), Icon(Icons.watch_later), Icon(Icons.watch_later)],
                      [Icon(Icons.watch_later), Icon(Icons.watch_later), Icon(Icons.watch_later)],
                      [Icon(Icons.watch_later), Icon(Icons.watch_later), Icon(Icons.watch_later)]
                    ],)
                ),
              );
            },
            child: const Icon(Icons.watch_later),
          ),
          FloatingActionButton(
            tooltip: Constants.SAVE_TODO_BUTTON_TOOLTIP,
            onPressed: () {
              _formKey.currentState.save();
              getIt<TodoListStore>().add(widget.todo);
              Navigator.pop(context);
            },
            child: const Icon(Icons.save),
          ),
        ],
      )
    );
  }
}


