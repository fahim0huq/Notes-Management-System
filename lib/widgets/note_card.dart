import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard(
      {super.key,
      required this.title,
      required this.description,
      required this.onEdit,
      required this.onDelete});

  final String title;
  final String description;

  final VoidCallback onEdit;
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed:onEdit, icon: Icon(Icons.edit)),
            IconButton(onPressed: onDelete, icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
