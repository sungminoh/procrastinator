import 'package:flutter/material.dart';
import 'package:my_app/todos/views/todo_edit_view.dart';
import 'package:my_app/todos/views/todo_list_view.dart';

import 'constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.ADD_TODO_ROUTE:
      return MaterialPageRoute(builder: (context) => TodoEditView());
    case Routes.HOME_ROUTE:
    default:
      return MaterialPageRoute(builder: (context) => TodoListView());
    // return MaterialPageRoute(
    //   builder: (context) => Scaffold(
    //     body: Center(
    //       child: Text('No path for ${settings.name}'),
    //     ),
    //   ),
    // );
  }
}
