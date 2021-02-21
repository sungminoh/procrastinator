// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TodoStore on _TodoStore, Store {
  final _$titleAtom = Atom(name: '_TodoStore.title');

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  final _$noteAtom = Atom(name: '_TodoStore.note');

  @override
  String get note {
    _$noteAtom.reportRead();
    return super.note;
  }

  @override
  set note(String value) {
    _$noteAtom.reportWrite(value, super.note, () {
      super.note = value;
    });
  }

  final _$completeAtom = Atom(name: '_TodoStore.complete');

  @override
  bool get complete {
    _$completeAtom.reportRead();
    return super.complete;
  }

  @override
  set complete(bool value) {
    _$completeAtom.reportWrite(value, super.complete, () {
      super.complete = value;
    });
  }

  final _$datetimeAtom = Atom(name: '_TodoStore.datetime');

  @override
  DateTime get datetime {
    _$datetimeAtom.reportRead();
    return super.datetime;
  }

  @override
  set datetime(DateTime value) {
    _$datetimeAtom.reportWrite(value, super.datetime, () {
      super.datetime = value;
    });
  }

  final _$intervalAtom = Atom(name: '_TodoStore.interval');

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

  final _$snoozeAtom = Atom(name: '_TodoStore.snooze');

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

  final _$_TodoStoreActionController = ActionController(name: '_TodoStore');

  @override
  void markDone() {
    final _$actionInfo =
        _$_TodoStoreActionController.startAction(name: '_TodoStore.markDone');
    try {
      return super.markDone();
    } finally {
      _$_TodoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void postpone() {
    final _$actionInfo =
        _$_TodoStoreActionController.startAction(name: '_TodoStore.postpone');
    try {
      return super.postpone();
    } finally {
      _$_TodoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
note: ${note},
complete: ${complete},
datetime: ${datetime},
interval: ${interval},
snooze: ${snooze}
    ''';
  }
}
