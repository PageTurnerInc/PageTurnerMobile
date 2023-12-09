import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_turner_mobile/wishlist/models/notes.dart';
import 'package:page_turner_mobile/wishlist/screens/show_notes.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class NotesCard extends StatelessWidget {
  final Notes note;

  const NotesCard(this.note, {super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Card(
      child: ListTile(
        title: Text(note.fields.title,
            style:
                const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        subtitle:
            Text(note.fields.notes, style: const TextStyle(fontSize: 16.0)),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            final response = await request.postJson(
                "https://pageturner-c06-tk.pbp.cs.ui.ac.id/wishlist/delete_note_flutter/",
                jsonEncode(<String, String>{
                  'noteID': note.pk.toString(),
                }));
            if (response['status'] == 'success') {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Note anda berhasil dihapus!"),
              ));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NotesPage()),
              );
            }
          },
        ),
      ),
    );
  } // Constructor
}
