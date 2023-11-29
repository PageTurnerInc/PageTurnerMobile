import 'package:flutter/material.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reviews & Ratings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),

      body: FutureBuilder(
        future: fetchReviews(), 
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "No Reviews & Ratings Yet",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8,)
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => InkWell(
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12
                    ),
                    
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "${snapshot.data![index].fields.reviewer}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),
                          Text(
                            "${snapshot.data![index].fields.date}"
                          ),

                          const SizedBox(height: 20),
                          Text(
                            "${snapshot.data![index].fields.comment}"
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              );
            }
          }
        }
      ),
    );
  }
}