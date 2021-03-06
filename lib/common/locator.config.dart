// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../todos/services/todo_database_service.dart' as _i5;
import '../todos/stores/todo_list_store.dart' as _i3;
import 'navigation.dart' as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.TodoList>(() => _i3.TodoList());
  gh.singleton<_i4.NavigationService>(_i4.NavigationService());
  gh.singleton<_i5.TodoDatabaseService>(_i5.TodoDatabaseService());
  return get;
}
