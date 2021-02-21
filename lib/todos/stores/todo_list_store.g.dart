// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TodoListStore on _TodoListStore, Store {
  final _$todosAtom = Atom(name: '_TodoListStore.todos');

  @override
  ObservableList<TodoStore> get todos {
    _$todosAtom.reportRead();
    return super.todos;
  }

  @override
  set todos(ObservableList<TodoStore> value) {
    _$todosAtom.reportWrite(value, super.todos, () {
      super.todos = value;
    });
  }

  final _$_TodoListStoreActionController =
      ActionController(name: '_TodoListStore');

  @override
  void remove(TodoStore todo) {
    final _$actionInfo = _$_TodoListStoreActionController.startAction(
        name: '_TodoListStore.remove');
    try {
      return super.remove(todo);
    } finally {
      _$_TodoListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void add(TodoStore todo) {
    final _$actionInfo = _$_TodoListStoreActionController.startAction(
        name: '_TodoListStore.add');
    try {
      return super.add(todo);
    } finally {
      _$_TodoListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
todos: ${todos}
    ''';
  }
}
