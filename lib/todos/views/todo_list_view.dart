import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_app/common/compoments/swipeable.dart';
import 'package:my_app/common/constants.dart';
import 'package:my_app/common/locator.dart';
import 'package:my_app/todos/stores/todo_store.dart';
import 'package:my_app/todos/stores/todo_list_store.dart';
import 'package:my_app/todos/views/todo_edit_view.dart';

/**
 * todo_list_view
 * @author sungminoh (smoh10@coupang.com)
 * @since 2/12/21.
 */
class TodoListView extends StatefulWidget {
  TodoListView();

  @override
  State createState() => _TodoListView();
}

class _TodoListView extends State<TodoListView> {
  void moveToEditView([Todo todo]) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TodoEditView(todo),
        )).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context) {
          TodoList todoList = getIt<TodoList>();
          return ListView.builder(
              itemCount: todoList.todos.length,
              itemBuilder: (context, index) {
                final Todo todo = todoList.todos[index];
                return Swipeable(
                  child: Container(
                      child: ListTile(
                        title: Text(todo.content ?? ""),
                        onTap: () => moveToEditView(todo),
                      ),
                      decoration: new BoxDecoration(
                          border: new Border(bottom: new BorderSide()))),
                  leftSwipeWidget: Icon(Icons.done),
                  onLeftSwipe: () => todo.markDone(),
                  rightSwipeWidget: Icon(Icons.delete),
                  onRightSwipe: () => todoList.remove(todo),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: Constants.ADD_TODO_BUTTON_TOOLTIP,
        onPressed: () => moveToEditView(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
