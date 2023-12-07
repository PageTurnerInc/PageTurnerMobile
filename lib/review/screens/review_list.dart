import 'package:flutter/material.dart';
import 'package:page_turner_mobile/daftar_belanja/widgets/navbar.dart';
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/review/models/review.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReviewsPage extends StatefulWidget {
  final Book book;

  const ReviewsPage({required this.book, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  Future<List<Review>> fetchReviews() async {
    var url = Uri.parse(
        'https://pageturner-c06-tk.pbp.cs.ui.ac.id/review/get-reviews-json-by-book-id/${widget.book.pk}/'
      ),
      response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );
    
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Review> listReview = [];
    for (var d in data) {
      if (d != null) {
        listReview.add(Review.fromJson(d));
      }
    }

    return listReview;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.92;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reviews & Ratings',
          style: TextStyle(color: Colors.black),
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
                      widget.book.fields.bookTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ]
            )
          ],
        ),
      )
    );
  }
}