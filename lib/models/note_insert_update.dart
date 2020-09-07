import 'package:flutter/foundation.dart';

class NoteInsertUpdate{
  String noteTitle;
  String noteContent;

  NoteInsertUpdate({@required this.noteTitle, @required this.noteContent});

  Map<String, dynamic> toJson () {
    return {
      'noteTitle' : noteTitle,
      'noteContent' : noteContent
    };
  }
}