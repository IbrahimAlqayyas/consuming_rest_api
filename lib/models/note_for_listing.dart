class NoteForListing {
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;

  NoteForListing({this.noteID, this.noteTitle, this.createDateTime, this.latestEditDateTime});


  // factory constructor --> Create instance of the class with data from outsource
  // the factory constructor will handle the correct data himself without declaration in the class
  factory NoteForListing.fromJson(Map<String, dynamic> item) {
    return NoteForListing(
      noteID: item ['noteID'],
      noteTitle: item ['noteTitle'],
      createDateTime: DateTime.parse(item ['createDateTime']), //item ['createDateTime'] is wrong because the api return a string not a DateTime object
      latestEditDateTime: item ['latestEditDateTime'] != null ? DateTime.parse (item ['latestEditDateTime'])
          : null, // not to crash when returning null
    );
  }
}
