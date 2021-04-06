import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/common/dart_api.dart';
import 'package:mobx/mobx.dart';
import 'package:my_app/common/locator.dart';
import 'package:my_app/common/utils.dart';
import 'package:my_app/todos/services/todo_database_service.dart';
import 'package:my_app/todos/stores/todo_list_store.dart';

part 'todo_store.g.dart';

class Todo extends _ObservableTodo {
  Todo();

  factory Todo.fromJson(Map<String, dynamic> json) {
    Todo todo = Todo();
    todo.id = json['id'];
    todo.content = json['content'];
    todo.imagePaths.addAll(json['imagePaths'].cast<String>());
    todo.dateTime = json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null;
    todo.timeZone = json['timeZone'];
    todo.interval = json['interval'];
    todo.snooze = json['snooze'];
    return todo;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'imagePaths': List<String>.of(this.imagePaths),
      'dateTime': dateTime?.toIso8601String(),
      'timeZone': timeZone,
      'interval': interval,
      'snooze': snooze,
    };
  }
}

class _ObservableTodo = _Todo with _$Todo;

abstract class _Todo with Store {
  int id;

  @observable
  String content = '';

  @observable
  ObservableList<String> imagePaths = ObservableList<String>();

  @computed
  List<FileImage> get images =>
      imagePaths.map((e) => FileImage(File(e))).toList();

  @observable
  DateTime dateTime;

  String timeZone = '';

  @observable
  Duration interval;

  @observable
  Duration snooze;

  @action
  void addImage(String imagePath) {
    if (imagePath.isNotEmpty) {
      this.imagePaths.add(imagePath);
    }
  }

  @action
  void delete() {
    images.forEach((fileImage) => fileImage.file.delete());
    getIt<TodoDatabaseService>().removeTodo(this);
  }

  @action
  void markDone() {
    // TODO
  }

  @computed
  bool get isEmpty => content.isNullOrEmpty && imagePaths.length == 0 && dateTime == null;
}
