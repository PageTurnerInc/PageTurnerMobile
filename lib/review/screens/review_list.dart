import 'package:flutter/material.dart';
import 'package:page_turner_mobile/daftar_belanja/widgets/navbar.dart';
import 'package:page_turner_mobile/katalog_buku/screens/book_detail.dart';
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/review/widgets/book_rate_widget.dart';
import 'package:page_turner_mobile/review/widgets/my_review_card.dart';
import 'package:page_turner_mobile/review/widgets/other_review_card.dart';

class ReviewsPage extends StatefulWidget {
  final Book book;

  const ReviewsPage({required this.book, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {

  @override
  Widget build(BuildContext context) {
    int maxCharacters = 19;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reviews & Ratings',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookPage(widget.book),
              ),
            );
          },
          color: Colors.black,
        ),
      ),

      bottomNavigationBar: NavBar(),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  widget.book.fields.imageUrlL,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300, // Adjust the height as needed
                ),
                Container(
                  width: double.infinity,
                  height: 300, // Ensure this matches the image's height
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.book.fields.bookTitle.length > maxCharacters
                              // ignore: prefer_interpolation_to_compose_strings
                              ? widget.book.fields.bookTitle.substring(0, maxCharacters) + '...'
                              : widget.book.fields.bookTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "by ${widget.book.fields.bookAuthor.length <= 16 ? 
                        widget.book.fields.bookAuthor : widget.book.fields.bookAuthor.substring(0, 16) + '...'}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6,),
                    BookRate(book: widget.book, isReviewList: true)
                  ],
                )
              ]
            ),
            const SizedBox(height: 10,),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 6,),
                        Text(
                          "Your Rating & Review",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    )
                  ]
                )
              ),
            ),
            MyReviewCard(book: widget.book),
            const SizedBox(height: 10,),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 6,),
                        Text(
                          "Others' Ratings & Reviews",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    )
                  ]
                )
              ),
            ),
            OtherReviewCard(book: widget.book)
          ],
        ),
      )
    );
  }
}