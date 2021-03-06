import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/**
 * grid_buttons
 * @author sungminoh (smoh10@coupang.com)
 * @since 2/20/21.
 */
class GridButtons extends StatefulWidget {
  final List<List<Widget>> children;
  final int width;
  final int height;

  GridButtons({Key key, this.children, this.width, this.height})
      : super(key: key);

  @override
  _GridButtonsState createState() => _GridButtonsState();
}

class _GridButtonsState extends State<GridButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: widget.children
          .map((row) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: row,
              ))
          .toList(growable: false),
    );
  }
}
