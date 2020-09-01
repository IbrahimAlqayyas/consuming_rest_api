import 'dart:convert';
import 'package:rest_api_trainning/models/api_response.dart';
import 'package:rest_api_trainning/models/note_for_listing.dart';
import 'package:http/http.dart' as http;

class NotesService {

  static const API = 'http://api.notes.programmingaddict.com';
  static const headers = {
    'apikey' : '1280d8b1-f3af-495b-9c87-3d2647c95ba9'
  };

    Future <APIResponse<List<NoteForListing>>> getNotesList () {
      /// http request

      return http.get(API + '/notes' /* tha path in the api*/, headers: headers).then ((data) {
        if (data.statusCode == 200) {
          final jsonData = jsonDecode(data.body); // returned from the API response
          final notes = <NoteForListing>[];

          // Iteration
          for (var item in jsonData) {
            final note = NoteForListing (
              noteID: item ['noteID'],
              noteTitle: item ['noteTitle'],
              createDateTime: DateTime.parse(item ['createDateTime']), //item ['createDateTime'] is wrong because the api return a string not a DateTime object
              latestEditedDateTime: item ['latestEditDateTime'] != null ? DateTime.parse (item ['latestEditDateTime'])
              : null, // not to crash when returning null
            );
            // add every iteration
            notes.add(note);
          }
          return APIResponse<List<NoteForListing>>(data: notes); // If 200
        }
        return APIResponse<List<NoteForListing>>(error: true, errorMessage: 'An error occurred');
      }).catchError((_) => APIResponse<List<NoteForListing>>(error: true, errorMessage: 'An error occurred'));
        /* now we can use this method in our note_list page*/
  }

}
