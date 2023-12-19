import 'dart:convert';
import "package:flutter/material.dart";
import 'package:page_turner_mobile/daftar_belanja/widgets/navbar.dart';
import 'package:page_turner_mobile/katalog_buku/screens/katalog_buku.dart';
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/review/widgets/review_bar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:page_turner_mobile/rak_buku/models/rak.dart';

class BookPage extends StatelessWidget {
  final Book book;

  const BookPage(this.book, {super.key});

  Future<void> _deleteBook(
    BuildContext context, CookieRequest request) async {
      await request.postJson(
        'https://pageturner-c06-tk.pbp.cs.ui.ac.id/katalog/remove-book-katalog-flutter/',
        jsonEncode(
          {
            "bookID": book.pk,
          }
        )
      );
    }

  Future<List<Rak>> fetchRak(CookieRequest request) async {
    var response = await request.get("https://pageturner-c06-tk.pbp.cs.ui.ac.id/rak_buku/get-rak/");

    List<Rak> listRak = [];
    for (var d in response) {
      if (d != null) {
        listRak.add(Rak.fromJson(d));
      }
    }
    return listRak;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        bottomNavigationBar: const NavBar(),
        appBar: AppBar(
            leading: BackButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookCataloguePage(),
                  ),
                )
              },
            ),
            title: const Text("Detail Buku")),
        body: FutureBuilder<List<Rak>>(
        future: fetchRak(request),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return SingleChildScrollView(
              child: Column(
            children: [
            Text(book.fields.bookTitle),
            Text("Year of publication: ${book.fields.yearOfPublication}"),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                book.fields.bookAuthor
              )
            ), 
            Image.network(book.fields.imageUrlL, fit: BoxFit.cover),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  _deleteBook(context, request);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookCataloguePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                  const Color.fromARGB(255, 205, 28, 28),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                      BorderRadius.circular(5), // Rounded edges
                  ),
                  padding:
                    const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Delete Book',
                  style: TextStyle(
                    fontSize: 12, // Font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            ReviewBar(book: book),

            const Text("You have no Library"),
          ],
              ),
            );
          }

          else {
            return SingleChildScrollView(
              child: Column(
            children: [
            Text(book.fields.bookTitle),
            Text("Year of publication: ${book.fields.yearOfPublication}"),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                book.fields.bookAuthor
              )
            ), 
            Image.network(book.fields.imageUrlL, fit: BoxFit.cover),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  _deleteBook(context, request);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookCataloguePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                  const Color.fromARGB(255, 205, 28, 28),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                      BorderRadius.circular(5), // Rounded edges
                  ),
                  padding:
                    const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Delete Book',
                  style: TextStyle(
                    fontSize: 12, // Font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            ReviewBar(book: book),

            const Text("Add to Library"),
            DropdownRakList(listRak: snapshot.data!, book: book),
          ],
              ),
            );
          }
        },
      ),
    );
  }
}

class DropdownRakList extends StatefulWidget {
  final List<Rak> listRak;
  final Book book;

  const DropdownRakList({required this.listRak, required this.book});

  @override
  _DropdownRakListState createState() => _DropdownRakListState();
}

class _DropdownRakListState extends State<DropdownRakList> {

  Future<void> _addBuku(
      BuildContext context, CookieRequest request, String? rakId) async {
      if (rakId != null) {
        int rak = int.parse(rakId);
        await request.postJson(
          'https://pageturner-c06-tk.pbp.cs.ui.ac.id/rak_buku/add_book_to_rak_flutter/',
          jsonEncode({
            "bookID": widget.book.pk,
            "rakID": rak,
          }),
        );
    }
  }

  @override
  Widget build(BuildContext context) {

    final request = context.watch<CookieRequest>();
    String selectedRak = widget.listRak[0].pk.toString();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

          const SizedBox(height: 20),
          DropdownButton<String>(
            value: selectedRak,
            
            onChanged: (String? newValue) {
              setState(() {
                selectedRak = newValue!;
              });
              _addBuku(context, request, newValue);
            },
            items: widget.listRak.map<DropdownMenuItem<String>>((Rak rak) {
              return DropdownMenuItem<String>(
                value: rak.pk.toString(),
                child: Text(rak.fields.name),
              );
            }).toList(),
          ),
        
      ],
    );
  }
}
