import 'package:equatable/equatable.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

part 'todo_store.g.dart';

class TodoStore = _TodoStore with _$TodoStore;


abstract class _TodoStore with Store {
  _TodoStore(): id = Uuid().v4();

  final String id;

  @observable
  String title;

  @observable
  String note;

  @observable
  bool complete;

  @observable
  DateTime datetime;

  @observable
  Duration interval;

  @observable
  Duration snooze;

  @action
  void markDone() {
    // TODO
    this.complete = !this.complete;
  }

  @action
  void postpone() {
    // TODO
  }

  @override
  String toString() {
    return '_TodoStore{id: $id, title: $title, note: $note, complete: $complete, datetime: $datetime}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _TodoStore &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          note == other.note &&
          complete == other.complete &&
          datetime == other.datetime;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      note.hashCode ^
      complete.hashCode ^
      datetime.hashCode;
}

