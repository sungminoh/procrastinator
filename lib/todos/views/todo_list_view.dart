import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_app/common/constants.dart';
import 'package:my_app/common/local_notification.dart';
import 'package:my_app/common/locator.dart';
import 'package:my_app/common/utils.dart';
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
  final TodoList todoList = getIt<TodoList>();

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
          return ListView.builder(
              itemCount: todoList.todos.length, itemBuilder: _buildItem);
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: Constants.ADD_TODO_BUTTON_TOOLTIP,
        onPressed: () => moveToEditView(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTile(Todo todo) {
    return Card(
      child: ListTile(
        leading: todo.images.length > 0
            ? CircleAvatar(
                backgroundImage: todo.images[0],
                foregroundColor: Colors.white,
              )
            : null,
        title: Text(
          todo.content,
          style: TextStyle(fontWeight: FontWeight.w600),
          overflow: TextOverflow.clip,
          maxLines: 1,
          softWrap: false,
        ),
        subtitle: Text(
          todo.content.split('\n').sublist(1).join('\n'),
          overflow: TextOverflow.clip,
          maxLines: 2,
          softWrap: false,
        ),
        trailing: todo.dateTime != null ? Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(formatDateTime(todo.dateTime)),
          Text(formatDateTimeDiff(DateTime.now(), todo.dateTime))
        ]) : null,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final Todo todo = todoList.todos[index];
    return GestureDetector(
      onTap: () => moveToEditView(todo),
      child: Slidable(
        key: Key(todo.id.toString()),
        actionPane: SlidableDrawerActionPane(),
        // Do not show action button. Just dismiss instead.
        actionExtentRatio: 0.0,
        child: _buildTile(todo),
        actions: <Widget>[
          IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => todoList.remove(todo)),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
              caption: 'Done',
              color: Colors.green,
              icon: Icons.done,
              onTap: () => todo.markDone()),
        ],
        dismissal: SlidableDismissal(
          // Dismiss immediately
          dismissThresholds: {
            SlideActionType.primary: 0.25,
            SlideActionType.secondary: 0.25,
          },
          child: SlidableDrawerDismissal(),
          onDismissed: (actionType) {
            if (actionType == SlideActionType.primary) {
              todoList.remove(todo);
            }
          },
          onWillDismiss: (actionType) async {
            if (actionType == SlideActionType.primary) {
              return true;
            } else {
              todo.markDone();
              return false;
            }
          },
        ),
      ),
    );
  }
}
