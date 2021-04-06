import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common/constants.dart';
import 'common/locator.dart';
import 'common/navigation.dart';
import 'common/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_TITLE,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonTheme: ButtonThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blue,
          secondary: Colors.lightBlue,
        )),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: getIt<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: Routes.HOME_ROUTE,
    );
  }
}
