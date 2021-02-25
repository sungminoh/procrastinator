// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TodoList on _TodoList, Store {
  final _$todosAtom = Atom(name: '_TodoList.todos');

  @override
  ObservableList<Todo> get todos {
    _$todosAtom.reportRead();
    return super.todos;
  }

  @override
  set todos(ObservableList<Todo> value) {
    _$todosAtom.reportWrite(value, super.todos, () {
      super.todos = value;
    });
  }

  final _$_TodoListActionController = ActionController(name: '_TodoList');

  @override
  void remove(Todo todo) {
    final _$actionInfo =
        _$_TodoListActionController.startAction(name: '_TodoList.remove');
    try {
      return super.remove(todo);
    } finally {
      _$_TodoListActionController.endAction(_$actionInfo);
    }
  }

  @override
  void update(Todo todo) {
    final _$actionInfo =
        _$_TodoListActionController.startAction(name: '_TodoList.update');
    try {
      return super.update(todo);
    } finally {
      _$_TodoListActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
todos: ${todos}
    ''';
  }
}
