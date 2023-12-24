import 'package:hive_flutter/hive_flutter.dart';

import '../models/note.dart';

class HiveDatabase {
  // Reference our hive database
  final _myBox = Hive.box('note_database');

  // Load notes
  List<Note> loadNotes() {
    List<Note> saveNotesFormatted = [];

    // If there exist note return that, otherwise return empty list
    if (_myBox.get("ALL_NOTES") != null) {
      List<dynamic> savedNotes = _myBox.get('ALL_NOTES');
      for (int i = 0; i < savedNotes.length; i++) {
        // Create individual note
        Note individualNote =
            Note(id: savedNotes[i][0], text: savedNotes[i][1]);
        // Add to list
        saveNotesFormatted.add(individualNote);
      }
    } else {
      saveNotesFormatted.add(Note(id: 0, text: 'Yay! This is a welcome note!'));
    }
    return saveNotesFormatted;
  }

  // Save notes
  void saveNotes(List<Note> allNotes) {
    List<List<dynamic>> allNotesFormatted = [
      /*
      Example:
        [0, "First note"],
        [1, "Second note"]
      */
    ];

    for (var note in allNotes) {
      int id = note.id;
      String text = note.text;
      allNotesFormatted.add([id, text]);
    }

    // Then store into hive
    _myBox.put("ALL_NOTES", allNotesFormatted);
  }
}
