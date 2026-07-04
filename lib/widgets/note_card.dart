import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

class Note{
  final String id;
  final String  title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note({
    required this.id,
    required this.description,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  //note object -> firestoremap
  Map<String,dynamic>toMap(){
    return{
      'title': title,
      'description':description,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  //firestore Document -> note object
  factory Note.fromDocument(DocumentSnapshot doc){
    final data = doc.data() as Map<String,dynamic>;
    return Note(
      id: doc.id,
    title: data['title'] ?? '',
    description: data['description']?? '',
    createdAt: (data['createdAt'] as Timestamp).toDate(),
    updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }
}