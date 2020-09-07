import 'package:flutter/material.dart';

class NoteDelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // because we need it to be a pop-up
    return AlertDialog(
      title: Text('warning'),
      content: Text('Are you sure you want to delete this note?'),
      actions: [
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop(true); // confirm delete
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop(
                false); // return false because i don't want to delete the note
          },
        )
      ],
    );
  }
}
