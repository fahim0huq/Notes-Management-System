import 'package:flutter/material.dart';
import 'package:note_management/models/note_model.dart';
import 'package:note_management/screens/EditNotesScreen.dart';
import 'package:note_management/services/firestore_service.dart';
import 'package:note_management/widgets/note_card.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await _firestoreService.getNotes();

    setState(() {
      _notes = notes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Notes"),
        backgroundColor: Colors.red,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: _notes.length,
          itemBuilder: (context, index) {
            return NoteCard(
              title: _notes[index].title,
              description: _notes[index].description,

              onEdit: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddEditNoteScreen(note: _notes[index]),
                  ),
                );

                await _loadNotes();
              },

              onDelete: () async {
                await _firestoreService.deleteNote(_notes[index]);
                await _loadNotes();
              },
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditNoteScreen(),
            ),
          );

          await _loadNotes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}