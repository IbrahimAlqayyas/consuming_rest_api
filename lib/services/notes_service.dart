import 'package:rest_api_trainning/models/note_for_listing.dart';

class NotesService {

  List<NoteForListing> getNotesList () {
    return [
      NoteForListing(
          noteId: '1',
          createDateTime: DateTime.now(),
          latestEditedDateTime: DateTime.now(),
          noteTitle: 'Note 1'
      ),
      NoteForListing(
          noteId: '2',
          createDateTime: DateTime.now(),
          latestEditedDateTime: DateTime.now(),
          noteTitle: 'Note 2'
      ),
      NoteForListing(
          noteId: '3',
          createDateTime: DateTime.now(),
          latestEditedDateTime: DateTime.now(),
          noteTitle: 'Note 3'
      ),
    ];
  }

}