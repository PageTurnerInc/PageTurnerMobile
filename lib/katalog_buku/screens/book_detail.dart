import 'dart:convert';
import "package:flutter/material.dart";
import 'package:page_turner_mobile/daftar_belanja/widgets/navbar.dart';
import 'package:page_turner_mobile/katalog_buku/screens/katalog_buku.dart';
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/review/widgets/review_bar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        bottomNavigationBar: const NavBar(),
        appBar: AppBar(
            leading: BackButton(
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text("Detail Buku")),
        body: SingleChildScrollView(
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
            
            ReviewBar(book: book)
          ],
        )
      )
    );
  }
}
