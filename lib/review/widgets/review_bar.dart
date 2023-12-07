import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/review/models/book_rating.dart';
import 'package:page_turner_mobile/review/models/review.dart';
import 'package:page_turner_mobile/review/screens/review_list.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';

class ReviewBar extends StatefulWidget {
  final Book book;

  const ReviewBar({required this.book, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ReviewBarState createState() => _ReviewBarState();
}

class _ReviewBarState extends State<ReviewBar> {
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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReviewsPage(book: widget.book)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent), // Atur border sesuai kebutuhan
          borderRadius: BorderRadius.circular(8), // Atur border radius sesuai kebutuhan
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reviews & Ratings',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6,),
            FutureBuilder<List<BookRating>>(
              future: fetchBookRating(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No ratings yet. Be the first to rate this by tapping me.');
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
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
                              Row(
                                children: List.generate(5, (index) {
                                  // Menentukan warna bintang berdasarkan rating
                                  Color starColor = index < rating.fields.rating.floor()
                                      ? Colors.blue
                                      : Colors.grey;

                                  return Icon(
                                    Icons.star,
                                    color: starColor,
                                    size: 20,
                                  );
                                }),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      const SizedBox(width: 20,),
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
                              .where((review) => review.fields.rating == 1).length;
                            int count2 = snapshot.data!
                              .where((review) => review.fields.rating == 2).length;
                            int count3 = snapshot.data!
                              .where((review) => review.fields.rating == 3).length;
                            int count4 = snapshot.data!
                              .where((review) => review.fields.rating == 4).length;
                            int count5 = snapshot.data!
                              .where((review) => review.fields.rating == 5).length;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                LinearPercentIndicator(
                                  width: 100, //width for progress bar
                                  animation: true, //animation to show progress at first
                                  animationDuration: 1000,
                                  leading: const Padding( //prefix content
                                    padding: EdgeInsets.only(right: 8),
                                    child: Text("5"), //left content
                                  ),
                                  trailing: Padding( //sufix content
                                    padding: const EdgeInsets.only(left: 8),
                                    child:Text("$count5 (${double.parse(((count5.toDouble() / reviewCount.toDouble()) * 100.0).toStringAsFixed(1))}%)"), //right content
                                  ),
                                  percent: double.parse(((count5.toDouble() / reviewCount.toDouble())).toStringAsFixed(1)), // 30/100 = 0.3
                                  progressColor: Colors.blue, //percentage progress bar color
                                  backgroundColor: Colors.grey[400],
                                ),
                                LinearPercentIndicator(
                                  width: 100, //width for progress bar
                                  animation: true, //animation to show progress at first
                                  animationDuration: 1000,
                                  leading: const Padding( //prefix content
                                    padding: EdgeInsets.only(right:8),
                                    child: Text("4"), //left content
                                  ),
                                  trailing: Padding( //sufix content
                                    padding: const EdgeInsets.only(left:8),
                                    child: Text("$count4 (${double.parse(((count4.toDouble() / reviewCount.toDouble()) * 100.0).toStringAsFixed(1))}%)"), //right content
                                  ),
                                  percent: double.parse(((count4.toDouble() / reviewCount.toDouble())).toStringAsFixed(1)), // 30/100 = 0.3
                                  progressColor: Colors.blue, //percentage progress bar color
                                  backgroundColor: Colors.grey[400],
                                ),
                                LinearPercentIndicator(
                                  width: 100, //width for progress bar
                                  animation: true, //animation to show progress at first
                                  animationDuration: 1000,
                                  leading: const Padding( //prefix content
                                    padding: EdgeInsets.only(right:8),
                                    child: Text("3"), //left content
                                  ),
                                  trailing: Padding( //sufix content
                                    padding: const EdgeInsets.only(left:8),
                                    child: Text("$count3 (${double.parse(((count3.toDouble() / reviewCount.toDouble()) * 100.0).toStringAsFixed(1))}%)"), //right content
                                  ),
                                  percent: double.parse(((count3.toDouble() / reviewCount.toDouble())).toStringAsFixed(1)), // 30/100 = 0.3
                                  progressColor: Colors.blue, //percentage progress bar color
                                  backgroundColor: Colors.grey[400],
                                ),
                                LinearPercentIndicator(
                                  width: 100, //width for progress bar
                                  animation: true, //animation to show progress at first
                                  animationDuration: 1000,
                                  leading: const Padding( //prefix content
                                    padding: EdgeInsets.only(right:8),
                                    child: Text("2"), //left content
                                  ),
                                  trailing: Padding( //sufix content
                                    padding: const EdgeInsets.only(left:8),
                                    child: Text("$count2 (${double.parse(((count2.toDouble() / reviewCount.toDouble()) * 100.0).toStringAsFixed(1))}%)"), //right content
                                  ),
                                  percent: double.parse(((count2.toDouble() / reviewCount.toDouble())).toStringAsFixed(1)), // 30/100 = 0.3
                                  progressColor: Colors.blue, //percentage progress bar color
                                  backgroundColor: Colors.grey[400],
                                ),
                                LinearPercentIndicator(
                                  width: 100, //width for progress bar
                                  animation: true, //animation to show progress at first
                                  animationDuration: 1000,
                                  leading: const Padding( //prefix content
                                    padding: EdgeInsets.only(right:8),
                                    child: Text("1"), //left content
                                  ),
                                  trailing: Padding( //sufix content
                                    padding: const EdgeInsets.only(left:8),
                                    child: Text("$count1 (${double.parse(((count1.toDouble() / reviewCount.toDouble()) * 100.0).toStringAsFixed(1))}%)"), //right content
                                  ),
                                  percent: double.parse(((count1.toDouble() / reviewCount.toDouble())).toStringAsFixed(1)), // 30/100 = 0.3
                                  progressColor: Colors.blue, //percentage progress bar color
                                  backgroundColor: Colors.grey[400],
                                ),
                              ],
                            );
                          }
                        },
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
