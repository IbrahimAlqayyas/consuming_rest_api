import 'dart:convert';
import 'package:rest_api_training/models/api_response.dart';
import 'package:rest_api_training/models/note_for_listing.dart';
import 'package:rest_api_training/models/note.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_training/models/note_insert_update.dart';

class NotesService {
  static const url = 'http://api.notes.programmingaddict.com';
  static const headers = {
    'apikey': '1280d8b1-f3af-495b-9c87-3d2647c95ba9',
    'Content-Type': 'application/json'
  };

  // Notes For Listing ---> http request // Return Data // or Return Error
  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http
        .get(url + '/notes' /* tha path in the api*/, headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData =
            jsonDecode(data.body); // returned from the API response
        final notes = <NoteForListing>[];
        // Iteration
        for (var item in jsonData) {
          final note = NoteForListing.fromJson(item);
          // add every iteration
          notes.add(note);
        }
        return APIResponse<List<NoteForListing>>(data: notes); // If 200
      }
      return APIResponse<List<NoteForListing>>(
          error: true, errorMessage: 'An error occurred');
    }).catchError((_) => APIResponse<List<NoteForListing>>(
            error: true, errorMessage: 'An error occurred'));
    /* now we can use this method in our note_list page*/
  }

  // GET a Note ---> http request // Return Data // or Return Error
  Future<APIResponse<Note>> getNote(String noteID) {
    return http.get(url + '/notes/' + noteID, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData =
            jsonDecode(data.body); // returned from the API response
        final note = Note.fromJson(jsonData);
        return APIResponse<Note>(data: note); // If 200 -- connection success
      }
      return APIResponse<Note>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) =>
        APIResponse<Note>(error: true, errorMessage: 'An error occurred'));
    /* now we can use this method in our note_list page*/
  }

  // CREATE a Note ---> http request //
  Future<APIResponse<bool>> createNote(NoteInsertUpdate note) {
    return http.post(url + '/notes', headers: headers, body: jsonEncode(note.toJson())).then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true); // If 201 -- adding resource success
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: 'An error occurred'));
    /* now we can use this method in our note_list page*/
  }

  // UPDATE a Note ---> http request //
  Future<APIResponse<bool>> updateNote(NoteInsertUpdate note, String noteID){
    return http.put(url + '/notes/' + noteID, headers: headers, body: jsonEncode(note.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true); // If 204 -- updating success
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: 'An error occurred'));
    /* now we can use this method in our note_list page*/
  }

  // DELETE a Note ---> http request //
  Future<APIResponse<bool>> deleteNote(String noteID){
    return http.delete(url + '/notes/' + noteID, headers: headers).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true); // If 200 -- deleting success
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: 'An error occurred'));
    /* now we can use this method in our note_list page*/
  }
}
