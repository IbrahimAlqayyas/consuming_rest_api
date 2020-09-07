import 'package:flutter/material.dart';
import 'package:rest_api_training/models/note.dart';
import 'package:rest_api_training/models/note_insert_update.dart';
import 'package:rest_api_training/services/notes_service.dart';
import 'package:get_it/get_it.dart';

class NoteCreateModify extends StatefulWidget {

  final String noteID;
  NoteCreateModify({this.noteID});

  @override
  _NoteCreateModifyState createState() => _NoteCreateModifyState();
}

class _NoteCreateModifyState extends State<NoteCreateModify> {
  // a function to make a status of editing
  bool get isEditing => widget.noteID != null;

  // API Service Call
  NotesService get notesService => GetIt.I<NotesService>();

  String errorMessage;
  Note note;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  bool _isLoading =
      false; //to check if getting the note operation is loading or not

  // API call
  @override
  void initState() {
    super.initState();
    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      notesService.getNote(widget.noteID).then((response) {
        setState(() {
          _isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage ??
              'An error occurred'; // In case of error without an error message
        }
        note = response.data;
        _titleController.text = note.noteTitle;
        _contentController.text = note.noteContent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(noteId == null ? 'Create Note' : 'Edit Note'),
        title: Text(isEditing ? 'Edit Note' : 'Create Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  /// note title text field
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(hintText: 'Note Title'),
                  ),

                  //Spacing between text fields
                  Container(height: 8),

                  /// note content text field
                  TextField(
                    controller: _contentController,
                    decoration: InputDecoration(hintText: 'Note Content'),
                  ),

                  Container(height: 16),

                  // to make the button take all the width space
                  SizedBox(
                      width: double.infinity,
                      height: 35,
                      /// Submit Button
                      child: RaisedButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          if (isEditing) {
                            //update note
                            setState(() {
                              _isLoading = true;
                            });

                            final note = NoteInsertUpdate(
                                noteTitle: _titleController.text,
                                noteContent: _contentController.text
                            );
                            final result = await notesService.updateNote(note, widget.noteID);

                            setState(() {
                              _isLoading = true;
                            });

                            final successMessage = 'Success!';
                            final text = result.error ? (result.errorMessage ?? 'An error occurred')
                                : 'Your note was updated!';

                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog (
                                  title: Text(successMessage),
                                  content: Text(text),
                                  actions: [
                                    FlatButton(
                                        child: Text('OK'),
                                        onPressed: () => Navigator.of(context).pop()
                                    )
                                  ],
                                )
                            ).then((data){
                              if(result.data){
                                Navigator.of(context).pop();
                              }
                            });
                          } else {
                            // add new note
                            setState(() {
                              _isLoading = true;
                            });

                            final note = NoteInsertUpdate(
                              noteTitle: _titleController.text,
                              noteContent: _contentController.text
                            );
                            final result = await notesService.createNote(note);

                            setState(() {
                              _isLoading = true;
                            });

                            final successMessage = 'Success!';
                            final text = result.error ? (result.errorMessage ?? 'An error occurred')
                                : 'Your note was created!';

                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog (
                                title: Text(successMessage),
                                content: Text(text),
                                actions: [
                                  FlatButton(
                                    child: Text('OK'),
                                    onPressed: () => Navigator.of(context).pop()
                                  )
                                ],
                              )
                            ).then((data){
                              if(result.data){
                                Navigator.of(context).pop();
                              }
                            });
                          }
                        },
                      ))
                ],
              ),
      ),
    );
  }
}
