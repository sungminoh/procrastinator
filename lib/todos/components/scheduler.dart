import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:my_app/common/compoments/grid_buttons.dart';
import 'package:my_app/common/compoments/time_editor.dart';
import 'package:my_app/common/models/time.dart';
import 'package:my_app/common/utils.dart';

/**
 * scheduler
 * @author sungminoh (smoh10@coupang.com)
 * @since 2/20/21.
 */
class Scheduler extends StatefulWidget {
  final DateTime dateTime;
  final DateChangedCallback onChange;
  final DateChangedCallback onConfirm;
  final DateChangedCallback onDeactivate;

  Scheduler({
    @required this.dateTime,
    this.onChange,
    this.onConfirm,
    this.onDeactivate,
  });

  @override
  _SchedulerState createState() => _SchedulerState();
}

class _SchedulerState extends State<Scheduler> {
  DateTime dateTime;

  void updateDateTime(DateTime dt) {
    setState(() {
      this.dateTime = dt;
    });
    if (widget.onChange != null) {
      widget.onChange(dt);
    }
  }

  @override
  void initState() {
    super.initState();
    updateDateTime(widget.dateTime);
  }

  Widget getEditableTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TimeEditor(
              dateTime: dateTime, onConfirm: (dt) => updateDateTime(dt)),
        ),
        widget.onConfirm != null
            ? MaterialButton(
                child: Text("Done"),
                onPressed: () {
                  widget.onConfirm(this.dateTime);
                  Navigator.pop(context, this.dateTime);
                },
              )
            : Text('')
      ],
    );
  }

  Widget timeToButton(Time time) {
    Widget title = Text('+10 min');
    if (time.absolute) {
      title = Text('${time.hour}:${time.minute.toString().padLeft(2, '0')}');
    } else if (time.day != null) {
      title = Text('${time.day} day');
    } else if (time.hour != null) {
      title = Text('${time.hour} hr');
    } else if (time.minute != null) {
      title = Text('${time.minute} min');
    }

    Function getTargetDate = () {
      if (time.absolute) {
        return nextDateTime(
          hour: time.hour,
          minute: time.minute,
        );
      } else if (time.day != null) {
        return this.dateTime.add(Duration(
          days: time.day,
        ));
      } else if (time.hour != null) {
        return this.dateTime.add(Duration(
          hours: time.hour,
        ));
      } else if (time.minute != null) {
        return this.dateTime.add(Duration(
          minutes: time.minute,
        ));
      }
    };

    return Expanded(
      child: OutlinedButton(
        child: title,
        onPressed: () => updateDateTime(getTargetDate()),
      ),
    );
  }

  @override
  void deactivate() {
    if (widget.onDeactivate != null) {
      widget.onDeactivate(this.dateTime);
    }
  }

  Widget getGridButtons() {
    // TODO: load from configuration
    List<List<Time>> times = [
      [
        Time(hour: 9, minute: 30, absolute: true),
        Time(hour: 12, minute: 0, absolute: true),
        Time(hour: 18, minute: 30, absolute: true),
        Time(hour: 22, minute: 0, absolute: true)
      ],
      [
        Time(minute: 10, absolute: false),
        Time(hour: 1, absolute: false),
        Time(hour: 3, absolute: false),
        Time(day: 1, absolute: false)
      ],
      [
        Time(minute: -10, absolute: false),
        Time(hour: -1, absolute: false),
        Time(hour: -3, absolute: false),
        Time(day: -1, absolute: false)
      ]
    ];

    return GridButtons(
      children: times.map((row) => row.map(timeToButton).toList()).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 50, child: getEditableTime()),
        Expanded(child: getGridButtons())
      ],
    );
  }
}
