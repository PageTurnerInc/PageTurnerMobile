import 'package:flutter/material.dart';
import 'package:page_turner_mobile/katalog_buku/screens/book_detail.dart';
import 'package:page_turner_mobile/menu/models/book.dart';

class BookDetailCard extends StatelessWidget {
  final Book book;

  const BookDetailCard(this.book, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded edges
      ),
      child: InkWell(
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookPage(book))
          );
        },
        child: SizedBox(
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
                        book.fields.bookTitle,
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