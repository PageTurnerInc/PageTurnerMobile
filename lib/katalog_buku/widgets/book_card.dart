// ignore_for_file: sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_turner_mobile/menu/models/account.dart';
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard(this.book, {super.key});

  Future<void> _addToCart(BuildContext context, CookieRequest request) async {
    await request.postJson(
        'http://127.0.0.1:8080/daftar_belanja/add_to_cart_flutter/',
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
          child: SingleChildScrollView(
            // Wrap with SingleChildScrollView
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
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
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
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    const Color.fromARGB(255, 31, 156, 35),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(5), // Rounded edges
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text(
                                'Add to Wishlist',
                                style: TextStyle(
                                  fontSize: 12, // Font size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    const Color.fromARGB(255, 31, 156, 35),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(5), // Rounded edges
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text(
                                'Book Details',
                                style: TextStyle(
                                  fontSize: 12, // Font size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                _addToCart(context, request);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    const Color.fromARGB(255, 31, 156, 35),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(5), // Rounded edges
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text(
                                'Add to Cart',
                                style: TextStyle(
                                  fontSize: 12, // Font size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
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
