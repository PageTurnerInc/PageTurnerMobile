import "package:flutter/material.dart";
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/review/widgets/review_bar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookPage extends StatelessWidget {
  final Book book;

  const BookPage(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
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

            ReviewBar(book: book)
          ],
        )));
  }
}
