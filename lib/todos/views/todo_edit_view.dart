import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/common/compoments/text_editor.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_app/common/compoments/floatting_modal.dart';
import 'package:my_app/common/local_notification.dart';
import 'package:my_app/common/locator.dart';
import 'package:my_app/common/utils.dart';
import 'package:my_app/common/dart_api.dart';
import 'package:my_app/todos/components/scheduler.dart';
import 'package:my_app/todos/stores/todo_list_store.dart';
import 'package:my_app/todos/stores/todo_store.dart';

import '../../common/compoments/image_slider.dart';

/**
 * todo_edit_view
 * @author sungminoh (smoh10@coupang.com)
 * @since 2/13/21.
 */
class TodoEditView extends StatefulWidget {
  final Todo todo;

  TodoEditView([
    Todo todo,
  ]) : this.todo = todo ?? Todo();

  @override
  _TodoEditViewState createState() => _TodoEditViewState();
}

class _TodoEditViewState extends State<TodoEditView> {
  // final _formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();
  final CarouselController buttonCarouselController = CarouselController();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    if (!widget.todo.isEmpty) {
      getIt<TodoList>().update(widget.todo);
    }
    this.textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Text controller
    if (!widget.todo.content.isNullOrEmpty) {
      this.textController.value = TextEditingValue(text: widget.todo.content);
    }
    this.textController.addListener(() {
      widget.todo.content = this.textController.text;
    });
    // Scroll controller
    this.scrollController.addListener(() {
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  Widget _getTimeSelectButton() {
    return MaterialButton(
      color: widget.todo.dateTime == null ||
              DateTime.now().isBefore(widget.todo.dateTime)
          ? Theme.of(context).buttonTheme.colorScheme.primary
          : Theme.of(context).buttonTheme.colorScheme.error,
      padding: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 5),
            child: Text(
                widget.todo.dateTime != null
                    ? '${formatDateTime(widget.todo.dateTime)}, ${formatDateTimeDiff(DateTime.now(), widget.todo.dateTime)}'
                    : 'No time set',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                )),
          ),
          GestureDetector(
            child: Opacity(
              opacity: 0.5,
              child: Icon(
                Icons.cancel_rounded,
                size: 15,
              ),
            ),
            onTap: () { widget.todo.dateTime = null; },
          ),
        ],
      ),
      onPressed: () {
        showFloatingModalBottomSheet(
          context: context,
          builder: (context) => SizedBox(
            height: 400,
            child: Scheduler(
                dateTime: widget.todo.dateTime ??
                    DateTime.now().add(Duration(minutes: 10)),
                onDeactivate: (dateTime) {
                  widget.todo.dateTime = dateTime;
                }),
          ),
        );
      },
    );
  }

  Widget _buildButtons() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(Icons.photo_camera),
            color: Colors.black,
            onPressed: () {
              getImage(ImageSource.camera).then((file) {
                if (file != null) {
                  widget.todo.addImage(file.path);
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.insert_photo),
            color: Colors.black,
            onPressed: () {
              getImage(ImageSource.gallery).then((file) {
                if (file != null) {
                  widget.todo.addImage(file.path);
                }
              });
            },
          ),
          _getTimeSelectButton(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
          builder: (context, viewportConstraints) => SingleChildScrollView(
            controller: scrollController,
            child: Observer(
              builder: (builder) => ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 60),
                    if (widget.todo.imagePaths.length > 0)
                      SizedBox(
                          height: 200,
                          child: ImageSlider(
                            widget.todo.images,
                            height: 200,
                          )),
                    SizedBox(
                      height: 500,
                      child: TextEditor(
                        content: widget.todo.content,
                        textController: textController,
                      ),
                    ),
                    // _buildButtons()
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: Observer(builder: (builder) => _buildButtons()));
  }
}
