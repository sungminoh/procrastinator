// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../todos/services/database_service.dart';
import 'navigation.dart';
import '../todos/stores/todo_list_store.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<TodoList>(() => TodoList());

  // Eager singletons must be registered in the right order
  gh.singleton<DatabaseService>(DatabaseService());
  gh.singleton<NavigationService>(NavigationService());
  return get;
}
