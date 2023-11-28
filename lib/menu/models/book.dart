// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

// ignore_for_file: sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';

List<Book> bookFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  String model;
  int pk;
  Fields fields;

  Book({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  String isbn;
  String bookTitle;
  String bookAuthor;
  int yearOfPublication;
  String publisher;
  String imageUrlS;
  String imageUrlM;
  String imageUrlL;
  dynamic user;

  Fields({
    required this.isbn,
    required this.bookTitle,
    required this.bookAuthor,
    required this.yearOfPublication,
    required this.publisher,
    required this.imageUrlS,
    required this.imageUrlM,
    required this.imageUrlL,
    required this.user,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        isbn: json["isbn"],
        bookTitle: json["book_title"],
        bookAuthor: json["book_author"],
        yearOfPublication: json["year_of_publication"],
        publisher: json["publisher"],
        imageUrlS: json["image_url_s"],
        imageUrlM: json["image_url_m"],
        imageUrlL: json["image_url_l"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "isbn": isbn,
        "book_title": bookTitle,
        "book_author": bookAuthor,
        "year_of_publication": yearOfPublication,
        "publisher": publisher,
        "image_url_s": imageUrlS,
        "image_url_m": imageUrlM,
        "image_url_l": imageUrlL,
        "user": user,
      };
}

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard(this.book, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    // Truncate title if it's longer than 42 characters
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
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan buku $title!")));
        },
        child: Container(
          height: 400, // Fixed height
          width: 250, // Fixed width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch to fill width
            children: [
              // Image covering top 60% of the card
              Expanded(
                flex: 7,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                  child: Image.network(
                    book.fields.imageUrlL,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              // Text content
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Book Title
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Book Author
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

