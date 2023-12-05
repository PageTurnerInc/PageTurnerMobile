import 'package:flutter/material.dart';
import 'package:page_turner_mobile/wishlist/widgets/notes_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:page_turner_mobile/wishlist/models/notes.dart';
import 'package:page_turner_mobile/daftar_belanja/widgets/navbar.dart';

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
      bottomNavigationBar: const NavBar(),
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
                return NotesCard(note);
              },
            );
          }
        },
      ),
    );
  }
}
