import 'package:flutter/material.dart';
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/review/models/review.dart';
import 'package:page_turner_mobile/review/widgets/star_generator.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class OtherReviewCard extends StatefulWidget {
  final Book book;

  const OtherReviewCard({required this.book, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OtherReviewCardState createState() => _OtherReviewCardState();
}

class _OtherReviewCardState extends State<OtherReviewCard> {
  Future<List<Review>> fetchReviews(request) async {
    var response = await request.get(
        "https://pageturner-c06-tk.pbp.cs.ui.ac.id/review/get-others-reviews-json/${widget.book.pk}/");

    List<Review> listMyReview = [];
    for (var d in response) {
      if (d != null) {
        listMyReview.add(Review.fromJson(d));
      }
    }

    return listMyReview;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Padding(
      padding: const EdgeInsets.all(0),
      child: FutureBuilder(
        future: fetchReviews(request),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Column(
              children: [
                Icon(
                  Icons.comments_disabled,
                ),
                Text(
                  "No ratings & reviews from other users yet"
                )
              ],
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => InkWell(
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                                  snapshot.data![index].fields.reviewer.length >
                                          10
                                      ? snapshot.data![index].fields.reviewer
                                              .substring(0, 10) +
                                          "..."
                                      : snapshot.data![index].fields.reviewer,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Text(
                                "${(snapshot.data![index].fields.date).day}-${(snapshot.data![index].fields.date).month}-${(snapshot.data![index].fields.date).year} ${(snapshot.data![index].fields.date).hour}:${(snapshot.data![index].fields.date).minute}:${(snapshot.data![index].fields.date).second}"),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            StarGenerator(
                                starsCount:
                                    (snapshot.data![index].fields.rating)
                                        .toDouble()),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(snapshot.data![index].fields.rating.toString())
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          // Check if the comment length is greater than 150
                          snapshot.data![index].fields.comment.length > 150
                              ? '${snapshot.data![index].fields.comment.substring(0, 150)}... '
                              : snapshot.data![index].fields.comment,
                        ),
                        // Conditionally show the "Read More" button
                        if (snapshot.data![index].fields.comment.length > 150 || snapshot.data![index].fields.reviewer.length > 10)
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
                                                snapshot.data![index].fields.reviewer,
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
                                                  "${(snapshot.data![index].fields.date).day}-${(snapshot.data![index].fields.date).month}-${(snapshot.data![index].fields.date).year} ${(snapshot.data![index].fields.date).hour}:${(snapshot.data![index].fields.date).minute}:${(snapshot.data![index].fields.date).second}",
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
                                                      (snapshot.data![index].fields.rating)
                                                          .toDouble()),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Text(snapshot.data![index].fields.rating.toString())
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
                                                  snapshot.data![index].fields.comment,
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
                                        child: Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Read More'),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
