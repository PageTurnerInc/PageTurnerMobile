import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:page_turner_mobile/wishlist/models/notes.dart';
import 'package:page_turner_mobile/menu/widgets/left_drawer.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  Future<List<Notes>> fetchNotes(request) async {
    var response = await request
        .get("https://pageturner-c06-tk.pbp.cs.ui.ac.id/wishlist/get_notes/");
    // melakukan konversi data json menjadi object Notes
    List<Notes> list_notes = [];
    for (var d in response) {
      print(Notes.fromJson(d));
      if (d != null) {
        list_notes.add(Notes.fromJson(d));
      }
    }

    return list_notes;
  }

  void deleteNote(int noteId) {
    // Logic to delete the note
    // You may need to send a request to your server to delete the note
    print("Deleting note with ID: $noteId");
    // Refresh the list after deletion
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Notes>>(
        future: fetchNotes(request),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Tidak ada catatan.",
                style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var note = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(note.fields.title,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                    subtitle: Text(note.fields.notes,
                        style: const TextStyle(fontSize: 16.0)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        final response = await request.postJson(
                            "https://pageturner-c06-tk.pbp.cs.ui.ac.id/wishlist/delete_note_flutter/",
                            jsonEncode(<String, String>{
                              'noteID': note.pk.toString(),
                            }));
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Note anda berhasil dihapus!"),
                          ));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotesPage()),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
