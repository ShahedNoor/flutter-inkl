import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkl/models/note_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../models/note.dart';

class EditingNotePage extends StatefulWidget {
  Note note;
  bool isNewNote;
  EditingNotePage({super.key, required this.note, required this.isNewNote});

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  QuillController _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    loadExistingNote();
  }

  // Load existing note
  void loadExistingNote() {
    final doc = Document()..insert(0, widget.note.text);
    setState(
      () {
        _controller = QuillController(
          document: doc,
          selection: const TextSelection.collapsed(offset: 0),
        );
      },
    );
  }

  // Add new note
  void addNewNote() {
    // Get new id
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    // Get text from editor
    String text = _controller.document.toPlainText();
    // Add the new note
    Provider.of<NoteData>(context, listen: false)
        .addNewNote(Note(id: id, text: text));
  }

  // Update existing note
  void updateNote() {
    // Get text from editor
    String text = _controller.document.toPlainText();
    // Update note
    Provider.of<NoteData>(context, listen: false).updateNote(widget.note, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            // If this is new note
            if (widget.isNewNote && !_controller.document.isEmpty()) {
              addNewNote();
            }

            // If this is an existing note
            else {
              updateNote();
            }
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          QuillToolbar.simple(
            configurations: QuillSimpleToolbarConfigurations(
              controller: _controller,
              showAlignmentButtons: false,
              showBackgroundColorButton: false,
              showCenterAlignment: false,
              showColorButton: false,
              showCodeBlock: false,
              showDirection: false,
              showFontFamily: false,
              showDividers: false,
              showIndent: false,
              showHeaderStyle: false,
              showLink: false,
              showSearchButton: false,
              showInlineCode: false,
              showQuote: false,
              showListNumbers: false,
              showListBullets: false,
              showClearFormat: false,
              showBoldButton: false,
              showFontSize: false,
              showItalicButton: false,
              showUnderLineButton: false,
              showStrikeThrough: false,
              showListCheck: false,
              showSuperscript: false,
              showSubscript: false,
              sharedConfigurations: const QuillSharedConfigurations(
                locale: Locale('de'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(25),
              child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
                  controller: _controller,
                  readOnly: false,
                  sharedConfigurations: const QuillSharedConfigurations(
                    locale: Locale('de'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
