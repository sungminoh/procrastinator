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
  final DateTime baseDateTime;
  final DateChangedCallback onDispose;

  Scheduler({
    DateTime baseDateTime,
    DateChangedCallback onDispose
  }) : this.baseDateTime = baseDateTime ?? DateTime.now().add(Duration(minutes: 10)),
        this.onDispose = onDispose ?? null;

  @override
  _SchedulerState createState() => _SchedulerState();
}

class _SchedulerState extends State<Scheduler> {
  DateTime dateTime;

  void updateDateTime(DateTime dt) {
    setState(() {
      this.dateTime = dt;
    });
  }

  @override
  void initState() {
    super.initState();
    updateDateTime(widget.baseDateTime);
  }

  Widget getEditableTime() {
    return TimeEditor(
        dateTime: this.dateTime,
        onConfirm: (dateTime) => updateDateTime(dateTime)
    );
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
  void dispose() {
    super.dispose();
    if (widget.onDispose != null) {
      widget.onDispose(this.dateTime);
    }
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