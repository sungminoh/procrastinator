import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 4,
      // number of method calls to be displayed
      errorMethodCount: 8,
      // number of method calls if stacktrace is provided
      lineLength: 120,
      // width of the output
      colors: false,
      // Colorful log messages
      printEmojis: true,
      // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
  level: Level.info,
);

String formatDateTime(DateTime dateTime) {
  DateFormat dateFormat = dateTime.year == DateTime.now().year
      ? DateFormat.MMMEd()
      : DateFormat.yMMMEd();
  return dateFormat.add_Hm().format(dateTime);
}

String formatDateTimeDiff(DateTime base, DateTime target) {
  Duration diff = target.difference(base.subtract(Duration(minutes: 1)));
  if (diff.inMinutes == 0) {
    return 'Now';
  }
  int mins =  diff.inMinutes > 0 ? diff.inMinutes : -diff.inMinutes + 1;
  int hours =  diff.inHours > 0 ? diff.inHours : -diff.inHours + 1;
  int days =  diff.inDays > 0 ? diff.inDays : -diff.inDays + 1;
  int weeks = ( diff.inDays > 0 ? diff.inDays : -diff.inDays + 1 / 7).ceil();
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

Future<File> getImage(ImageSource imageSource) async {
  ImagePicker picker = new ImagePicker();
  PickedFile imageFile = await picker.getImage(source: imageSource);
  if (imageFile == null) {
    return null;
  }
  File tmpFile = File(imageFile.path);
  final appDir = await getApplicationDocumentsDirectory();
  final fileName = basename(imageFile.path);
  return tmpFile.copy('${appDir.path}/$fileName');
}

Future<Size> getImageSize(File file) async {
  return file.readAsBytes().then((bytes) => decodeImageFromList(bytes)).then(
      (decodedImage) =>
          Size(decodedImage.width.toDouble(), decodedImage.height.toDouble()));
}

Future<Size> getImageSizeFit(BuildContext context, File file) async {
  Size screen = MediaQuery.of(context).size;
  return getImageSize(file).then((size) {
    double ratio = size.height / size.width;
    double screenRatio = screen.height / screen.width;
    if (ratio > screenRatio) {
      return Size(screen.height / ratio, screen.height);
    }
    return Size(screen.width, screen.width * ratio);
  });
}

DateTime nextDateTime({int year, int month, int day, int hour, int minute, int second, int weekday}) {
  assert(day == null || weekday == null);
  DateTime ret = DateTime.now();
  List<int> current = [ret.year, ret.month, ret.day, ret.hour, ret.minute, ret.second];
  if (second != null) {
    ret = DateTime(ret.year, ret.month, ret.day, ret.hour, ret.minute, ret.second + (second - ret.second) % 60);
  }
  if (minute != null) {
    ret = DateTime(ret.year, ret.month, ret.day, ret.hour, ret.minute + (minute - ret.minute) % 60, ret.second);
  }
  if (hour != null) {
    ret = DateTime(ret.year, ret.month, ret.day, ret.hour + (hour - ret.hour) % 24, ret.minute, ret.second);
  }
  if (day != null) {
    ret = DateTime(ret.year, ret.month, ret.day + (day - ret.day) % DateUtils.getDaysInMonth(ret.year, ret.month), ret.hour, ret.minute, ret.second);
  }
  if (weekday != null) {
    ret = DateTime(ret.year, ret.month, ret.day + (weekday - ret.weekday) % 7, ret.hour, ret.minute, ret.second);
  }
  if (month != null) {
    ret = DateTime(ret.year, ret.month + (month - ret.month) % 12, ret.day, ret.hour, ret.minute, ret.second);
  }
  if (year != null) {
    assert(year > ret.year);
    ret = DateTime(year, ret.month, ret.day, ret.hour, ret.minute, ret.second);
  }
  return ret;
}
