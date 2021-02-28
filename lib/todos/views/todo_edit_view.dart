import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/common/compoments/text_editor.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_app/common/compoments/floatting_modal.dart';
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
    if (!widget.todo.content.isNullOrEmpty) {
      this.textController.value = TextEditingValue(text: widget.todo.content);
    }
    this.textController.addListener(() {
      widget.todo.content = this.textController.text;
    });
  }

  Widget _getTimeSelectButton() {
    return MaterialButton(
      color: Theme.of(context).buttonTheme.colorScheme.background,
      padding: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(Icons.watch_later),
          SizedBox(
            width: 10,
          ),
          Text(
              widget.todo.dateTime != null
                  ? formatDateTime(widget.todo.dateTime)
                  : 'No time set',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              )),
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

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (builder) => Scaffold(
              body: Column(
                children: <Widget>[
                  SizedBox(height: 60),
                  if (widget.todo.images.length > 0)
                    SizedBox(
                      height: 300,
                      child: ImageSlider(widget.todo.images),
                    ),
                  Expanded(
                      child: TextEditor(
                    content: widget.todo.content,
                    textController: textController,
                  )),
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _getTimeSelectButton(),
                        IconButton(
                          icon: Icon(Icons.photo_camera),
                          color: Colors.black,
                          onPressed: () {
                            // getImage(ImageSource.camera)
                            //     .then((file) {
                            //   if (file != null) {
                            //     widget.todo.addImage(file.path);
                            //   }
                            // });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.insert_photo),
                          color: Colors.black,
                          onPressed: () async {
                            // MultiImagePicker.pickImages(
                            //   maxImages: 300,
                            // ).then((value) {
                            //   logger.i(value.map((e) => Asset).toList());
                            // });
                            getImage(ImageSource.gallery).then((file) {
                              if (file != null) {
                                widget.todo.addImage(file.path);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
