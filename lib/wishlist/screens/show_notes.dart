import 'package:flutter/material.dart';
import 'package:page_turner_mobile/wishlist/screens/notes_form.dart';
import 'package:page_turner_mobile/wishlist/widgets/notes_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:page_turner_mobile/wishlist/models/notes.dart';
import 'package:page_turner_mobile/daftar_belanja/widgets/navbar.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  Future<List<Notes>> fetchNotes(request) async {
    var response = await request
        .get("https://pageturner-c06-tk.pbp.cs.ui.ac.id/wishlist/get_notes/");
    // melakukan konversi data json menjadi object Notes
    List<Notes> listNotes = [];
    for (var d in response) {
      if (d != null) {
        listNotes.add(Notes.fromJson(d));
      }
    }

    return listNotes;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        bottomNavigationBar: const NavBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotesFormPage(),
              ),
            );
          },
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          child: const Icon(Icons.note_add),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/owned_book_bg.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200, 
                ),
                Container(
                  width: double.infinity,
                  height: 200, 
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.65),
                        Color.fromRGBO(0, 0, 0, 0.85),
                      ],
                    ),
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Notes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<Notes>>(
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
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var note = snapshot.data![index];
                          return NotesCard(note);
                        });
                  }
                })
          ],
        )));
  }
}
