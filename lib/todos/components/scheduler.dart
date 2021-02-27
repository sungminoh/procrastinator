import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:my_app/common/compoments/grid_buttons.dart';
import 'package:my_app/common/compoments/time_editor.dart';
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
              dateTime: dateTime,
              onConfirm: (dt) => updateDateTime(dt)
          ),
        ),
        widget.onConfirm != null ? MaterialButton(
          child: Text("Done"),
          onPressed: () {
            widget.onConfirm(this.dateTime);
            Navigator.pop(context, this.dateTime);
          },
        ) : Text('')
      ],
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
    return GridButtons(
      children: [
        [Icon(Icons.watch_later), Icon(Icons.watch_later), Icon(Icons.watch_later)],
        [Icon(Icons.watch_later), Icon(Icons.watch_later), Icon(Icons.watch_later)],
        [Icon(Icons.watch_later), Icon(Icons.watch_later), Icon(Icons.watch_later)],
        [Icon(Icons.watch_later), Icon(Icons.watch_later), Icon(Icons.watch_later)]
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 50, child: getEditableTime()),
        Expanded(child: getGridButtons())
      ],);
  }

}