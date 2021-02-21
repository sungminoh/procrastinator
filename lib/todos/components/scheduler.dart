import 'package:flutter/material.dart';
import 'package:my_app/common/compoments/grid_buttons.dart';

/**
 * scheduler
 * @author sungminoh (smoh10@coupang.com)
 * @since 2/20/21.
 */
class Scheduler extends StatefulWidget {
  Scheduler({Key key}) : super(key: key);

  @override
  _SchedulerState createState() => _SchedulerState();
}

class _SchedulerState extends State<Scheduler> {
  Widget getEditableTime() {
  }
  Widget getGridButtons() {
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

    return Container();
  }
}