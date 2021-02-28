import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:my_app/common/locator.dart';
import 'package:my_app/common/utils.dart';
import 'package:my_app/todos/services/database_service.dart';
import 'package:my_app/todos/stores/todo_store.dart';

part 'todo_list_store.g.dart';

@lazySingleton
class TodoList = _TodoList with _$TodoList;

abstract class _TodoList with Store {
  _TodoList() {
    logger.d('TodoList is initialized');
    load();
  }

  Future load() async {
    logger.d('TodoList loads todos');
    this.todos = ObservableList.of(await getIt<DatabaseService>().getTodos());
  }

  @observable
  ObservableList<Todo> todos = ObservableList<Todo>();

  @action
  void remove(Todo todo) {
    todos.removeWhere((e) => e.id == todo.id);
    todo.delete();
  }

  @action
  void update(Todo todo) {
    if (this.todos.where((element) => element.id == todo.id).isEmpty) {
      getIt<DatabaseService>().addTodo(todo);
    } else {
      getIt<DatabaseService>().updateTodo(todo);
    }
    load();
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
