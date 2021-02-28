import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/common/constants.dart';

class TextEditor extends StatelessWidget {
  const TextEditor({
    Key key,
    @required this.content,
    @required this.textController,
  }) : super(key: key);

  final String content;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
