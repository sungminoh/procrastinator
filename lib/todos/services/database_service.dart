import 'dart:convert';

import 'package:async/async.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/common/utils.dart';
import 'package:my_app/todos/stores/todo_store.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String TODO_DB = 'todo_database.db';
const String TODO_TABLE = 'todos';

@singleton
class DatabaseService {
  final _initDBMemoizer = AsyncMemoizer<Database>();
  Future<Database> _database;

  Map<String, dynamic> toDict(Todo todo) {
    Map<String, dynamic> json = todo.toJson();
    if (json.containsKey('id')) {
      return {'id': json.remove('id'), 'json': jsonEncode(json)};
    }
    return {'json': jsonEncode(json)};
  }

  Todo toTodo(Map<String, dynamic> data) {
    Todo todo = Todo.fromJson(jsonDecode(data['json']));
    if (data.containsKey('id')) {
      todo.id = data['id'];
    }
    return todo;
  }

  DatabaseService() {
    this.database;
  }

  Future<Database> get database async {
    if (_database != null) return _database;
    return _initDBMemoizer.runOnce(() => initalize());
  }

  Future<String> _getPath() async {
    return join(await getDatabasesPath(), TODO_DB);
  }

  Future<void> _deleteDatabase() async {
    String path = await _getPath();
    return deleteDatabase(path).then((value) {
      logger.d('Delete $path');
    }).onError((error, stackTrace) {
      logger.e('Fail to delete db', error, stackTrace);
    });
  }

  Future<Database> initalize() async {
    String path = await _getPath();
    logger.d('Initializing _database at $path');
    // await _deleteDatabase();
    return openDatabase(path,
        onOpen: (db) => logger.d('Database $TODO_DB opened'),
        onCreate: (db, version) {
          db.execute('''
            CREATE TABLE $TODO_TABLE(
              id INTEGER PRIMARY KEY,
              json TEXT
            )
            ''').then((value) {
            logger.d('Table $TODO_TABLE created');
          }).onError((error, stackTrace) {
            logger.e('Fail to create table', error, stackTrace);
          });
        },
        version: 1);
  }

  Future<List<Todo>> getTodos() async {
    // Get all the data from the TodoTableName
    logger.d('get todos from database');
    return database
        .then((db) => db.query(TODO_TABLE))
        .then((results) => results.map(toTodo).toList());
  }

  Future<void> addTodo(Todo todo) async {
    database
        .then((db) => db.insert(TODO_TABLE, toDict(todo)))
        .then((value) => todo.id = value)
        .onError((error, stackTrace) {
      logger.e('Fail to insert $todo', error, stackTrace);
      return error;
    });
  }

  Future<void> updateTodo(Todo todo) async {
    database
        .then(
            (db) => db.update(TODO_TABLE, toDict(todo), where: 'id=${todo.id}'))
        .onError((error, stackTrace) {
      logger.e('Fail to update $todo', error, stackTrace);
      return error;
    });
  }

  Future<void> removeTodo(Todo todo) async {
    database
        .then((db) => db.delete(TODO_TABLE, where: 'id=${todo.id}'))
        .onError((error, stackTrace) {
      logger.e('Fail to update $todo', error, stackTrace);
      return error;
    });
  }

  Future updateCompleteForTodo({int id, bool complete}) async {
    // try {
    //   await _database.update(
    //     TODO_TABLE,
    //     // We only pass in the data we want to update.
    //     // The field used here already has to exist in the schema
    //     {'complete': complete ? 1 : 0},
    //     where: 'id = ?',
    //     whereArgs: [id],
    //   );
    // } catch (e) {
    //   print('Could not update the todo with id:$id. $e');
    // }
  }
}
