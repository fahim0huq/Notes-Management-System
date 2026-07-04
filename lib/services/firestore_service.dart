import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_management/models/note_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _notesCollection =
      _firestore.collection("notes");
  Future<void> addNote(Note note) async {
    await _notesCollection.add(note.toMap());
  }

  Future<List<Note>> getNotes() async {
    QuerySnapshot snapshot = await _notesCollection.get();
    return snapshot.docs.map((doc) => Note.fromDocument(doc)).toList();
  }

  Future<void> updateNote(Note note) async {
    await _notesCollection.doc(note.id).update(note.toMap());
  }

  Future<void> deleteNote(Note note) async {
    await _notesCollection.doc(note.id).delete();
  }
}
