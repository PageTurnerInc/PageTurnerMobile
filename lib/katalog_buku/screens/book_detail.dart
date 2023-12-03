import "package:flutter/material.dart";
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/katalog_buku/screens/katalog_buku.dart';

class BookPage extends StatelessWidget {
  final Book book;

  const BookPage(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BookCataloguePage())),
        ),
        title: const Text("Detail Buku")
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              book.fields.bookTitle
            ),
            
            Text(
              "Year of publication: ${book.fields.yearOfPublication}"
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                book.fields.bookAuthor
              )
            ),
          ],
        )
      )
    );
  }
}