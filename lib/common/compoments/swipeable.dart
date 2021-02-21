import 'package:flutter/material.dart';

/**
 * swipeable
 * @author sungminoh (smoh10@coupang.com)
 * @since 2/15/21.
 */
class Swipeable extends StatefulWidget {
  final Widget child;
  final Widget rightSwipeWidget;
  final Widget longRightSwipeWidget;
  final Widget leftSwipeWidget;
  final Widget longLeftSwipeWidget;
  final VoidCallback onRightSwipe;
  final VoidCallback onLongRightSwipe;
  final VoidCallback onLeftSwipe;
  final VoidCallback onLongLeftSwipe;
  final Duration animationDuration;
  final double offsetDx;
  final double sensitivity;

  Swipeable({
    @required this.child,
    this.rightSwipeWidget,
    this.longRightSwipeWidget,
    this.leftSwipeWidget,
    this.longLeftSwipeWidget,
    this.onRightSwipe,
    this.onLeftSwipe,
    this.onLongRightSwipe,
    this.onLongLeftSwipe,
    this.animationDuration = const Duration(milliseconds: 150),
    this.offsetDx = 0.5,
    this.sensitivity = 1,
  }) : assert(child != null, "You must pass a child widget.");

  @override
  _SwipeableState createState() => _SwipeableState();
}

class _SwipeableState extends State<Swipeable>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;
  Animation<double> _leftIconAnimation;
  Animation<double> _rightIconAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: widget.animationDuration
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(curve: Curves.decelerate, parent: _controller),
    );
    _leftIconAnimation = _controller.drive(
      Tween<double>(begin: 0.0, end: 0.0),
    );
    _rightIconAnimation = _controller.drive(
      Tween<double>(begin: 0.0, end: 0.0),
    );
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runAnimation(double dx) {
    //set child animation
    _animation = Tween(
      begin: Offset.zero,
      end: Offset(dx.sign * widget.offsetDx, 0.0),
    ).animate(
      CurvedAnimation(curve: Curves.decelerate, parent: _controller),
    );
    //set back left/right icon animation
    if (dx > 0) {
      _leftIconAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.decelerate, parent: _controller),
      );
    } else {
      _rightIconAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.decelerate, parent: _controller),
      );
    }
    //Forward animation
    _controller.forward().whenComplete(() {
      _controller.reverse().whenComplete(() {
        if (dx > 0) {
          //keep left icon visibility to 0.0 until onRightSwipe triggers again
          _leftIconAnimation = _controller.drive(Tween(begin: 0.0, end: 0.0));
          widget.onRightSwipe();
        } else {
          //keep right icon visibility to 0.0 until onLeftSwipe triggers again
          _rightIconAnimation = _controller.drive(Tween(begin: 0.0, end: 0.0));
          widget.onLeftSwipe();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx.abs() > widget.sensitivity) {
          _runAnimation(details.delta.dx);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Visibility(
                visible: widget.onRightSwipe != null,
                child: AnimatedOpacity(
                  opacity: _leftIconAnimation.value,
                  duration: widget.animationDuration,
                  curve: Curves.decelerate,
                  child: widget.rightSwipeWidget?? Container()
                ),
              ),
              Visibility(
                visible: widget.onLeftSwipe != null,
                child: AnimatedOpacity(
                  opacity: _rightIconAnimation.value,
                  duration: widget.animationDuration,
                  curve: Curves.decelerate,
                  child: widget.leftSwipeWidget ?? Container()
                ),
              ),
            ],
          ),
          SlideTransition(
            position: _animation,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
