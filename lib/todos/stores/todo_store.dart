import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

part 'todo_store.g.dart';


@JsonSerializable()
class Todo extends _ObservableTodo {
  Todo();
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);
}


class _ObservableTodo = _Todo with _$Todo;


abstract class _Todo with Store {
  int id;

  @observable
  String content;

  @observable
  String imagePath;

  @observable
  DateTime dateTime;

  String timeZone;

  @observable
  Duration interval;

  @observable
  Duration snooze;

  @action
  void markDone(){
    // TODO
  }

  // static TodoStore fromJson(Map<String, dynamic> json) {
  //   return TodoStore(
  //     id: json['id'],
  //     content: json['content'],
  //     imagePath: json['imagePath'],
  //     complete: json['complete'],
  //     dateTime: json['dateTime'],
  //     interval: json['interval'],
  //     snooze: json['snooze'],
  //   );
  // }
}

