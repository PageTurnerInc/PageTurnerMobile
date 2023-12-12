import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/review/models/book_rating.dart';
import 'package:page_turner_mobile/review/models/review.dart';
import 'package:page_turner_mobile/review/widgets/percent_bar.dart';
import 'package:page_turner_mobile/review/widgets/star_generator.dart';
import 'package:http/http.dart' as http;

class BookRate extends StatefulWidget {
  final Book book;
  final bool isReviewList;

  const BookRate({required this.book, required this.isReviewList, Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookRateState createState() => _BookRateState();
}

class _BookRateState extends State<BookRate> {
  Future<List<BookRating>> fetchBookRating() async {
    var url = Uri.parse(
      'https://pageturner-c06-tk.pbp.cs.ui.ac.id/review/get-book-rating-by-book-id/${widget.book.pk}/',
    );
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<BookRating> listRating = [];
    for (var d in data) {
      if (d != null) {
        listRating.add(BookRating.fromJson(d));
      }
    }

    return listRating;
  }

  Future<List<Review>> fetchReviews() async {
    var url = Uri.parse(
            'https://pageturner-c06-tk.pbp.cs.ui.ac.id/review/get-reviews-json-by-book-id/${widget.book.pk}/'),
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
    if (widget.isReviewList) {
      return FutureBuilder<List<BookRating>>(
        future: fetchBookRating(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text(
              'No ratings yet.',
              style: TextStyle(color: Colors.white),
            );
          } else {
            return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                children: snapshot.data!.map((rating) {
                  return Column(
                    children: [
                      Text(
                        rating.fields.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FutureBuilder<List<Review>>(
                        future: fetchReviews(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Text('0');
                          } else {
                            int reviewCount = snapshot.data?.length ?? 0;
                            return Text(
                              '$reviewCount Review(s)',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            );
                          }
                        },
                      ),
                      StarGenerator(starsCount: rating.fields.rating)
                    ],
                  );
                }).toList(),
              ),
            ]);
          }
        },
      );
    } else {
      return FutureBuilder<List<BookRating>>(
        future: fetchBookRating(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text(
                'No ratings yet. Be the first to rate this by tapping me.');
          } else {
            // print(snapshot.data!.isEmpty);
            return Row(
              children: [
                Column(
                  children: snapshot.data!.map((rating) {
                    return Column(
                      children: [
                        Text(
                          rating.fields.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FutureBuilder<List<Review>>(
                          future: fetchReviews(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Text('0');
                            } else {
                              int reviewCount = snapshot.data?.length ?? 0;
                              return Text(
                                '$reviewCount Review(s)',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              );
                            }
                          },
                        ),
                        StarGenerator(starsCount: rating.fields.rating)
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(
                  width: 20,
                ),
                FutureBuilder<List<Review>>(
                  future: fetchReviews(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('0');
                    } else {
                      int reviewCount = snapshot.data?.length ?? 0;
                      // print(reviewCount);
                      int count1 = snapshot.data!
                          .where((review) => review.fields.rating == 1)
                          .length;
                      int count2 = snapshot.data!
                          .where((review) => review.fields.rating == 2)
                          .length;
                      int count3 = snapshot.data!
                          .where((review) => review.fields.rating == 3)
                          .length;
                      int count4 = snapshot.data!
                          .where((review) => review.fields.rating == 4)
                          .length;
                      int count5 = snapshot.data!
                          .where((review) => review.fields.rating == 5)
                          .length;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          PercentBar(
                              count: count5, total: reviewCount, index: 5),
                          PercentBar(
                              count: count4, total: reviewCount, index: 4),
                          PercentBar(
                              count: count3, total: reviewCount, index: 3),
                          PercentBar(
                              count: count2, total: reviewCount, index: 2),
                          PercentBar(
                              count: count1, total: reviewCount, index: 1),
                        ],
                      );
                    }
                  },
                )
              ],
            );
          }
        },
      );
    }
  }
}
