import 'dart:convert';

import "package:flutter/material.dart";
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/katalog_buku/screens/katalog_buku.dart';
import 'package:page_turner_mobile/wishlist/screens/wishlist_items.dart';
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

            ElevatedButton(
              onPressed: () async {
                  final response = await request.postJson(
                  "https://pageturner-c06-tk.pbp.cs.ui.ac.id/wishlist/add_to_wishlist_flutter/",
                  jsonEncode(<String, String>{
                      'bookID': book.pk.toString(),
                      
                  }));
                  if (response['status'] == 'success') {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                      content: Text("Wishlist anda berhasil disimpan!"),
                      ));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => WishlistPage()),
                      );
                  }
              },
              child: const Text('Add to Wishlist'),
            ),
          ],
        )
      )
    );
  }
}
