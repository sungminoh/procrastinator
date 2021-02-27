import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/common/constants.dart';

class TextEditor extends StatelessWidget {
  const TextEditor({
    Key key,
    @required this.content,
    @required this.textController,
    this.image
  }) : super(key: key);

  final String content;
  final TextEditingController textController;
  final File image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (image != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 80.0,
              height: 95.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: FileImage(image),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TextField(
            controller: textController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            autofocus: true,
            decoration: InputDecoration.collapsed(
              hintText: Constants.TODO_NOTE_PLACEHOLDER,
            ),
            // onSaved: (value) => todo.content = value
          ),
        ),
      ],
    );
  }
}
