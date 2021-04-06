import 'package:get_it/get_it.dart';
import 'package:my_app/todos/services/todo_database_service.dart';
import 'package:my_app/todos/stores/todo_list_store.dart';

import 'constants.dart';
import 'local_notification.dart';
import 'navigation.dart';

GetIt getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerSingleton<NavigationService>(NavigationService());
  getIt.registerSingleton<TodoDatabaseService>(TodoDatabaseService());
  getIt.registerLazySingleton<TodoList>(() => TodoList());
  getIt.registerSingleton<TodoNotification>(TodoNotification());
}
