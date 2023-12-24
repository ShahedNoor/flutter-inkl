import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkl/models/note.dart';
import 'package:provider/provider.dart';

import '../models/note_data.dart';
import 'editing_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNote();
  }

  // Create a note
  createNewNote() {
    // Create a new id
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;

    // Create a blank note
    Note newNote = Note(id: id, text: '');

    // Go to edit the note
    goToNotePage(newNote, true);
  }

  // Go to note editing page
  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditingNotePage(
          note: note,
          isNewNote: isNewNote,
        ),
      ),
    );
  }

  // Delete note
  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[300],
          elevation: 0,
          onPressed: createNewNote,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 75),
              child: Text(
                'Notes',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            value.getAllNotes().isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Center(
                      child: Text(
                        'Currently there are no notes!',
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  )
                : CupertinoListSection.insetGrouped(
                    children: List.generate(
                      value.allNotes.length,
                      (index) => CupertinoListTile(
                        title: Text(value.getAllNotes()[index].text),
                        onTap: () =>
                            goToNotePage(value.getAllNotes()[index], false),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.grey[300],),
                          onPressed: () {
                            deleteNote(value.getAllNotes()[index]);
                          },
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
