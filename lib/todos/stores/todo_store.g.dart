// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return Todo()
    ..id = json['id'] as int
    ..content = json['content'] as String
    ..imagePath = json['imagePath'] as String
    ..dateTime = json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String)
    ..timeZone = json['timeZone'] as String
    ..interval = json['interval'] == null
        ? null
        : Duration(microseconds: json['interval'] as int)
    ..snooze = json['snooze'] == null
        ? null
        : Duration(microseconds: json['snooze'] as int);
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'imagePath': instance.imagePath,
      'dateTime': instance.dateTime?.toIso8601String(),
      'timeZone': instance.timeZone,
      'interval': instance.interval?.inMicroseconds,
      'snooze': instance.snooze?.inMicroseconds,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Todo on _Todo, Store {
  Computed<File> _$imageComputed;

  @override
  File get image => (_$imageComputed ??=
          Computed<File>(() => super.image, name: '_Todo.image'))
      .value;
  Computed<bool> _$isEmptyComputed;

  @override
  bool get isEmpty => (_$isEmptyComputed ??=
          Computed<bool>(() => super.isEmpty, name: '_Todo.isEmpty'))
      .value;

  final _$contentAtom = Atom(name: '_Todo.content');

  @override
  String get content {
    _$contentAtom.reportRead();
    return super.content;
  }

  @override
  set content(String value) {
    _$contentAtom.reportWrite(value, super.content, () {
      super.content = value;
    });
  }

  final _$imagePathAtom = Atom(name: '_Todo.imagePath');

  @override
  String get imagePath {
    _$imagePathAtom.reportRead();
    return super.imagePath;
  }

  @override
  set imagePath(String value) {
    _$imagePathAtom.reportWrite(value, super.imagePath, () {
      super.imagePath = value;
    });
  }

  final _$dateTimeAtom = Atom(name: '_Todo.dateTime');

  @override
  DateTime get dateTime {
    _$dateTimeAtom.reportRead();
    return super.dateTime;
  }

  @override
  set dateTime(DateTime value) {
    _$dateTimeAtom.reportWrite(value, super.dateTime, () {
      super.dateTime = value;
    });
  }

  final _$intervalAtom = Atom(name: '_Todo.interval');

  @override
  Duration get interval {
    _$intervalAtom.reportRead();
    return super.interval;
  }

  @override
  set interval(Duration value) {
    _$intervalAtom.reportWrite(value, super.interval, () {
      super.interval = value;
    });
  }

  final _$snoozeAtom = Atom(name: '_Todo.snooze');

  @override
  Duration get snooze {
    _$snoozeAtom.reportRead();
    return super.snooze;
  }

  @override
  set snooze(Duration value) {
    _$snoozeAtom.reportWrite(value, super.snooze, () {
      super.snooze = value;
    });
  }

  final _$_TodoActionController = ActionController(name: '_Todo');

  @override
  void setImage(String imagePath) {
    final _$actionInfo =
        _$_TodoActionController.startAction(name: '_Todo.setImage');
    try {
      return super.setImage(imagePath);
    } finally {
      _$_TodoActionController.endAction(_$actionInfo);
    }
  }

  @override
  void markDone() {
    final _$actionInfo =
        _$_TodoActionController.startAction(name: '_Todo.markDone');
    try {
      return super.markDone();
    } finally {
      _$_TodoActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
content: ${content},
imagePath: ${imagePath},
dateTime: ${dateTime},
interval: ${interval},
snooze: ${snooze},
image: ${image},
isEmpty: ${isEmpty}
    ''';
  }
}
