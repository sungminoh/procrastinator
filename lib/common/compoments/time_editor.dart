import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:my_app/common/utils.dart';

/**
 * time_editor
 * @author sungminoh (smoh10@coupang.com)
 * @since 2/20/21.
 */
class TimeEditor extends StatelessWidget {
  final DateTime dateTime;
  final DateChangedCallback onChanged;
  final DateChangedCallback onConfirm;

  TimeEditor({
    @required this.dateTime,
    this.onConfirm,
    this.onChanged,
  });

  Widget getText() {
    String formattedDate = formatDateTime(this.dateTime);
    String dateDiff = formatDateDiff(DateTime.now(), this.dateTime);
    return Text('$formattedDate, $dateDiff');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: getText(),
      onPressed: () {
        DatePicker.showDateTimePicker(context,
            currentTime: this.dateTime,
            onChanged: this.onChanged,
            onConfirm: this.onConfirm,
            locale: LocaleType.en);
      },
    );
  }
}
