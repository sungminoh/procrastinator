import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:my_app/todos/stores/todo_list_store.dart';
import 'package:my_app/todos/stores/todo_store.dart';

import 'constants.dart';
import 'locator.dart';
import 'navigation.dart';

/**
 * notification
 * @author sungminoh (smoh10@coupang.com)
 * @since 3/6/21.
 */
class LocalNotification {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final SelectNotificationCallback onSelectNotification;
  final DidReceiveLocalNotificationCallback
      onDidReceiveLocalNotificationCallback;

  LocalNotification(
      {this.onSelectNotification, this.onDidReceiveLocalNotificationCallback})
      : this.flutterLocalNotificationsPlugin = createPlugin(
            onSelectNotification, onDidReceiveLocalNotificationCallback);

  static FlutterLocalNotificationsPlugin createPlugin(
      SelectNotificationCallback onSelectNotification,
      DidReceiveLocalNotificationCallback
          onDidReceiveLocalNotificationCallback) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings android =
        AndroidInitializationSettings('flutter_devs');
    IOSInitializationSettings ios = IOSInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotificationCallback);
    InitializationSettings initSettings =
        InitializationSettings(android: android, iOS: ios);

    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: onSelectNotification,
    );
    return flutterLocalNotificationsPlugin;
  }

  Future<bool> requestIosPermission() async {
    return this
        .flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  NotificationDetails getDetail() {
    AndroidNotificationDetails android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
        priority: Priority.high,
        importance: Importance.max,
        icon: 'flutter_devs',
        largeIcon: DrawableResourceAndroidBitmap('flutter_devs'));
    IOSNotificationDetails iOS = IOSNotificationDetails();
    NotificationDetails detail =
        NotificationDetails(android: android, iOS: iOS);
    return detail;
  }

  Future<void> showNotification(
      {int id, String title, String body, String payload}) async {
    await flutterLocalNotificationsPlugin.show(id, title, body, getDetail(),
        payload: payload);
  }

  Future<void> scheduleNotification(
      {DateTime at, int id, String title, String body, String payload}) async {
    await flutterLocalNotificationsPlugin
        .schedule(id, title, body, at, getDetail(), payload: payload);
  }

  Future<void> deleteNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}

class TodoNotification extends LocalNotification {
  TodoNotification()
      : super(onSelectNotification: (String payload) {
          return getIt<NavigationService>().navigateTo(Routes.EDIT_TODO_ROUTE,
              arguments: getIt<TodoList>()
                  .todos
                  .where((todo) => todo.id.toString() == payload)
                  .first);
        });

  Future<void> showTodoNotification(Todo todo) async {
    await flutterLocalNotificationsPlugin.show(
        todo.id, Constants.APP_TITLE, todo.content, getDetail(),
        payload: todo.id.toString());
  }

  Future<void> scheduleTodoNotification(Todo todo) async {
    await flutterLocalNotificationsPlugin.schedule(
        todo.id, Constants.APP_TITLE, todo.content, todo.dateTime, getDetail(),
        payload: todo.id.toString());
  }
}
