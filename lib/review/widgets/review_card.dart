import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/review/models/review.dart';
import 'package:page_turner_mobile/review/screens/review_list.dart';
import 'package:page_turner_mobile/review/screens/review_update.dart';
import 'package:page_turner_mobile/review/widgets/star_generator.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewCard extends StatelessWidget {
  final Book book;
  final Review review;
  final bool isMyReview;

  const ReviewCard({required this.book, required this.review, required this.isMyReview, Key? key}) : super(key: key);

  Future<void> _removeReview(BuildContext context, CookieRequest request) async {
    // Is this right
    await request.postJson(
      "https://pageturner-c06-tk.pbp.cs.ui.ac.id/review/delete-review-flutter/",
    jsonEncode(<String, int>{
        "book-id": book.pk,
        "review-id": review.pk
    }));
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.3;

    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person_pin_rounded,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        review.fields.reviewer.length > 10
                          ? review.fields.reviewer.substring(0, 10) + "..."
                          : review.fields.reviewer,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Text(
                      "${(review.fields.date).day}-${(review.fields.date).month}-${(review.fields.date).year} ${(review.fields.date).hour}:${(review.fields.date).minute}:${(review.fields.date).second}"),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  StarGenerator(
                    starsCount:
                      (review.fields.rating)
                          .toDouble()),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(review.fields.rating.toString())
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                // Check if the comment length is greater than 150
                review.fields.comment.length > 150
                    ? '${review.fields.comment.substring(0, 150)}... '
                    : review.fields.comment,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Conditionally show the "Read More" button
                  if (review.fields.comment.length > 150 || review.fields.reviewer.length > 10)
                    TextButton(
                      onPressed: () {
                        // Show a modal (dialog) with the full comment
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.person_pin_rounded,
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          review.fields.reviewer,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${(review.fields.date).day}-${(review.fields.date).month}-${(review.fields.date).year} ${(review.fields.date).hour}:${(review.fields.date).minute}:${(review.fields.date).second}",
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      )
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: [
                                        StarGenerator(
                                            starsCount:
                                                (review.fields.rating)
                                                    .toDouble()),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(review.fields.rating.toString())
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            review.fields.comment,
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      )
                                    ),
                                  ],
                                )
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Close the modal
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Read More'),
                    ),
                  if (isMyReview)
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: const SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Are you sure you want to delete this review?",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ],
                                          )
                                        ),
                                        SizedBox(
                                          height: 18,
                                        ),
                                        
                                      ],
                                    )
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: buttonWidth,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    _removeReview(context, request);
                                                    Navigator.pop(context);
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ReviewsPage(book: book,),
                                                      ),
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    foregroundColor: Colors.white,
                                                    backgroundColor: const Color.fromARGB(255, 205, 28, 28),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(5), // Rounded edges
                                                    ),
                                                    padding:
                                                        const EdgeInsets.symmetric(vertical: 12),
                                                  ),
                                                  child: const Text(
                                                    'Remove Review',
                                                    style: TextStyle(
                                                      fontSize: 12, // Font size
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ),

                                        TextButton(
                                          onPressed: () {
                                            // Close the modal
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          }, 
                          child: const Text(
                            "Delete",
                            style: TextStyle(
                              color: Colors.red
                            ),
                          )
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviewUpdatePage(book: book, review: review,),
                              ),
                            );
                          }, 
                          child: const Text(
                            "Update",
                            style: TextStyle(
                              color: Colors.green
                            ),
                          )
                        )
                      ],
                    )
                  ],
                )
            ],
          ),
        ),
      );
  }
}
