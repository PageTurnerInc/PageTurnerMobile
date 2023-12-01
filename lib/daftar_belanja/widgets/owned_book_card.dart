// ignore_for_file: sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_turner_mobile/daftar_belanja/screens/owned_books.dart';
import 'package:page_turner_mobile/menu/models/account.dart';
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard(this.book, {super.key}); // Constructor
  
  Future<void> _deleteBook(
    BuildContext context, CookieRequest request) async {
    await request.postJson(
        'http://127.0.0.1:8080/daftar_belanja/delete_book_flutter/',
        jsonEncode({
          "user": currentUser.user,
          "bookID": book.pk,
        }));
  }

  void _showModal(BuildContext context, request) {
    String title = book.fields.bookTitle;
    if (title.length > 42) {
      title = "${title.substring(0, 42)}...";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView( // Wrap with SingleChildScrollView
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  automaticallyImplyLeading: false,
                  title: Text(
                    title,
                    style: const TextStyle(fontSize: 20),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.network(book.fields.imageUrlL, fit: BoxFit.cover),
                      const SizedBox(height: 10),
                      Text(
                        book.fields.bookAuthor,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle Book Details
                            },
                            child: const Text('Book Details'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _deleteBook(context, request);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OwnedBooksPage(),
                                ),
                              );
                            },
                            child: const Text('Delete Book'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    String title = book.fields.bookTitle;
    if (title.length > 42) {
      title = "${title.substring(0, 42)}...";
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded edges
      ),
      child: InkWell(
        onTap: () async {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: Text("Kamu telah menekan buku $title!")));
          _showModal(context, request);
        },
        child: Container(
          height: 400, // Fixed height
          width: 250, // Fixed width
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Stretch to fill width
            children: [
              Expanded(
                flex: 8,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10.0)),
                  child: Image.network(
                    book.fields.imageUrlL,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        book.fields.bookAuthor,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}