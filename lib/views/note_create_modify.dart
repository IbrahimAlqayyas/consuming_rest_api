import 'package:flutter/material.dart';

class NoteCreateModify extends StatelessWidget {

  final String noteId;
  // a function to make a status of editing
  // to use in the appBar title and the RaisedButton action
  bool get isEditing => noteId != null;

  NoteCreateModify({this.noteId});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(noteId == null ? 'Create Note' : 'Edit Note'),
        title: Text(isEditing ? 'Edit Note' : 'Create Note'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Note Title'
              ),
            ),

            //Spacing between text fields
            Container(height: 8),

            TextField(
              decoration: InputDecoration(
                  hintText: 'Note Content'
              ),
            ),

            Container(height: 16),

            // to make the button take all the width space
            SizedBox(
              width: double.infinity,
              height: 35,
              child:
                RaisedButton(
                  child: Text('Submit', style: TextStyle(color: Colors.white),),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (isEditing) {
                      // update notes in API

                    } else {
                      // create new note in API

                    }

                    Navigator.of(context).pop();
                  },
                )
            )
          ],
        ),
      ),
    );
  }

}
