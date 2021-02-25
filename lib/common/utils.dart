import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
  ),
);


String formatDateTime(DateTime dateTime) {
  DateFormat dateFormat = dateTime.year == DateTime.now().year
      ? DateFormat.MMMEd()
      : DateFormat.yMMMEd();
  return dateFormat.add_Hm().format(dateTime);
}


String formatDateDiff(DateTime base, DateTime target) {
  Duration diff = target.difference(base.subtract(Duration(minutes: 1)));
  if (diff.inMinutes == 0) {
    return 'Now';
  }
  int mins = diff.inMinutes.abs();
  int hours = diff.inHours.abs();
  int days = diff.inDays.abs();
  int weeks = (diff.inDays.abs() / 7).ceil();
  int months = target.month - base.month;
  String text;
  if (mins < 60) {
    text = Intl.plural(mins, one: '1 min', other: '${mins} mins');
  } else if (hours < 24) {
    text = Intl.plural(hours, one: '1 hour', other: '${hours} hours');
  } else if (days < 14) {
    text = Intl.plural(days, one: '1 day', other: '${days} days');
  } else if (days < 84) {
    text = Intl.plural(weeks, one: '1 week', other: '${weeks} weeks');
  } else {
    text = '${months} months';
  }
  return diff.isNegative ? '$text ago' : 'in $text';
}