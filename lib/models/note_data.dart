import 'package:flutter/foundation.dart';
import 'package:inkl/data/hive_database.dart';

import 'note.dart';

class NoteData extends ChangeNotifier {
  // Initialize hive database
  final db = HiveDatabase();

  // Overall list of note
  List<Note> allNotes = [
    // Note(id: 0, text: "First Note"),
    // Note(id: 1, text: "Second Note"),
  ];

  // Initialize list
  void initializeNote() {
    allNotes = db.loadNotes();
  }

  // Get notes
  List<Note> getAllNotes() {
    return allNotes;
  }

  // Add a new note
  void addNewNote(Note note) {
    allNotes.add(note);
    notifyListeners();
  }

  // Update a note
  void updateNote(Note note, String text) {
    // Go throw list of notes
    for (int i = 0; i < allNotes.length; i++) {
      // Find the relevant note
      if (allNotes[i].id == note.id) {
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }

  // Delete a note
  void deleteNote(Note note) {
    allNotes.remove(note);
    notifyListeners();
  }
}
