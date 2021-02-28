// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Todo on _Todo, Store {
  Computed<List<FileImage>> _$imagesComputed;

  @override
  List<FileImage> get images => (_$imagesComputed ??=
          Computed<List<FileImage>>(() => super.images, name: '_Todo.images'))
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

  final _$imagePathsAtom = Atom(name: '_Todo.imagePaths');

  @override
  ObservableList<String> get imagePaths {
    _$imagePathsAtom.reportRead();
    return super.imagePaths;
  }

  @override
  set imagePaths(ObservableList<String> value) {
    _$imagePathsAtom.reportWrite(value, super.imagePaths, () {
      super.imagePaths = value;
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
  void addImage(String imagePath) {
    final _$actionInfo =
        _$_TodoActionController.startAction(name: '_Todo.addImage');
    try {
      return super.addImage(imagePath);
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
imagePaths: ${imagePaths},
dateTime: ${dateTime},
interval: ${interval},
snooze: ${snooze},
images: ${images},
isEmpty: ${isEmpty}
    ''';
  }
}
