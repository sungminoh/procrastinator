import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:my_app/common/utils.dart';
import 'package:my_app/todos/stores/todo_store.dart';


part 'todo_list_store.g.dart';

@lazySingleton
class TodoListStore = _TodoListStore with _$TodoListStore;


abstract class _TodoListStore with Store {
  @observable
  ObservableList<TodoStore> todos = ObservableList<TodoStore>();

  @action
  void remove(TodoStore todo) {
    todos.removeWhere((element) => element.id == todo.id);
  }

  @action
  void add(TodoStore todo) {
    if (this.todos.where((element) => element.id == todo.id).isEmpty) {
      this.todos.add(todo);
    }
  }

  void dispose() {
    logger.i("todo list is disposed");
    // TODO
  }
}


