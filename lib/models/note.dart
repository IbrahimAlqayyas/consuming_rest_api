

class Note {
  String noteID;
  String noteTitle;
  String noteContent;
  DateTime createDateTime;
  DateTime latestEditDateTime;

  Note({this.noteID, this.noteTitle, this.noteContent, this.createDateTime, this.latestEditDateTime});

  // factory constructor --> Create instance of the class with data from outsource
  // the factory constructor will handle the correct data himself without declaration in the class
  factory Note.fromJson(Map<String, dynamic> item) {
    return Note(
      noteID: item ['noteID'],
      noteTitle: item ['noteTitle'],
      noteContent: item ['noteContent'],
      createDateTime: DateTime.parse(item ['createDateTime']), //item ['createDateTime'] is wrong because the api return a string not a DateTime object
      latestEditDateTime: item ['latestEditDateTime'] != null ? DateTime.parse (item ['latestEditDateTime'])
          : null, // not to crash when returning null
    );
  }

}