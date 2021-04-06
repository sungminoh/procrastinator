import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:my_app/common/locator.dart';
import 'package:my_app/common/utils.dart';
import 'package:my_app/todos/services/todo_database_service.dart';
import 'package:my_app/todos/stores/todo_store.dart';

part 'todo_list_store.g.dart';

class TodoList = _TodoList with _$TodoList;

abstract class _TodoList with Store {
  _TodoList() {
    logger.d('TodoList is initialized');
    load();
  }

  Future load() async {
    logger.d('TodoList loads todos');
    this.todos = ObservableList.of(await getIt<TodoDatabaseService>().getTodos());
  }

  @observable
  ObservableList<Todo> todos = ObservableList<Todo>();

  @action
  void remove(Todo todo) {
    todos.removeWhere((e) => e.id == todo.id);
    todo.delete();
  }

  @action
  Future<Todo> update(Todo todo) async {
    Future<Todo> ret;
    if (this.todos.where((element) => element.id == todo.id).isEmpty) {
      ret = getIt<TodoDatabaseService>().addTodo(todo);
    } else {
      ret = getIt<TodoDatabaseService>().updateTodo(todo);
    }
    await ret;
    load();
    return ret;
  }

  // @action
  // void markDone(Todo todo) {
  //   todo.markDone()
  //   if (this.todos.where((element) => element.id == todo.id).isEmpty) {
  //     getIt<DatabaseService>().addTodo(todo);
  //   } else {
  //     getIt<DatabaseService>().updateTodo(todo);
  //   }
  //   load();
  // }

  void dispose() {
    logger.d("todo list is disposed");
    // TODO
  }
}
