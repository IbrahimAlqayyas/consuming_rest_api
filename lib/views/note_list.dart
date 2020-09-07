import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api_training/models/api_response.dart';
import 'package:rest_api_training/models/note_for_listing.dart';
import 'package:rest_api_training/services/notes_service.dart';
import 'package:rest_api_training/views/note_create_modify.dart';
import 'note_delete.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {
  // final service = NotesService(); // bad idea .. use service locator GetIT
  /// read the properties of the object NotesService (access the class)
  //var service = GetIt.instance.get<NotesService>();
  NotesService get service => GetIt.instance<NotesService>();
  APIResponse<List<NoteForListing>> _apiResponse;
  bool _isLoading = false;

  // a method to format the date and time
  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day} / ${dateTime.month} /${dateTime.year}';
  }

  /////////////////// init Method ///////////////////
  @override
  void initState() {
    setState(() {
      _fetchNotes();
    });
    super.initState();
  }

  /////////////////// fetchNotes Method ///////////////////
  _fetchNotes() async {

    setState(() {
      _isLoading = true;  //1
    });

    _apiResponse = await service.getNotesList();  //2

    setState(() {
      _isLoading = false;  //3
    });

  }

  /////////////////// build Method ///////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Note List'),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => NoteCreateModify())).then((_) => _fetchNotes()); // .then is working after we comeback from the push
            }),
        body: Builder(
          builder: (_) {
            if (_isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (_apiResponse.error) {
              return Center(
                child: Text(_apiResponse.errorMessage),
              );
            }

            return ListView.separated(
              separatorBuilder: (_, __) => Divider(
                height: 1,
                color: Colors.green,
              ),
              itemBuilder: (_, index) {
                return Dismissible(
                  key: ValueKey(_apiResponse.data[index].noteID),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                        context: context, builder: (_) => NoteDelete());

                    var message;
                    if (result) {
                      final deleteResult = await service.deleteNote(_apiResponse.data[index].noteID);
                      if (deleteResult != null && deleteResult.data){
                        message = 'The note was deleted successfully';
                      } else {
                        message = deleteResult?.errorMessage ?? 'An error occurred';
                      }

                      // Show a SnackBar with the deletion successful message
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog (
                            title: Text('Success!'),
                            content: Text(message),
                            actions: [
                              FlatButton(
                                  child: Text('OK'),
                                  onPressed: () => Navigator.of(context).pop()
                              )
                            ],
                          )
                      );
                      return deleteResult?.data ?? false;
                    }
                    print(result);
                    return result;
                  },
                  child: ListTile(
                    title: Text(
                      _apiResponse.data[index].noteTitle,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(
                        'Last edited on ${formatDateTime(_apiResponse.data[index].latestEditDateTime ?? _apiResponse.data[index].createDateTime)}'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => NoteCreateModify(
                              noteID: _apiResponse.data[index].noteID))).then((data) => _fetchNotes());
                    },
                  ),
                  background: Container(
                    //alignment: Alignment.centerLeft,
                    color: Colors.red,
                    padding: EdgeInsets.only(left: 16),
                    child: Align(
                      child: Icon(Icons.delete, color: Colors.white),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                );
              },
              itemCount: _apiResponse.data.length,
            );
          },
        ));
  }
}
