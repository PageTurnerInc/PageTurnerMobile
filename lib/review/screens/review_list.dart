import 'package:flutter/material.dart';
import 'package:page_turner_mobile/daftar_belanja/widgets/navbar.dart';
import 'package:page_turner_mobile/katalog_buku/screens/book_detail.dart';
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/review/models/review.dart';
import 'package:page_turner_mobile/review/screens/review_form.dart';
import 'package:page_turner_mobile/review/widgets/book_rate_widget.dart';
import 'package:page_turner_mobile/review/widgets/review_card.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewsPage extends StatefulWidget {
  final Book book;

  const ReviewsPage({required this.book, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  Future<List<Review>> fetchMyReview(request) async {
    var response = await request.get(
        "https://pageturner-c06-tk.pbp.cs.ui.ac.id/review/get-reviews-json-by-request-id/${widget.book.pk}/");

    List<Review> listMyReview = [];
    for (var d in response) {
      if (d != null) {
        listMyReview.add(Review.fromJson(d));
      }
    }

    return listMyReview;
  }

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

  List<String> ratings = <String>['All Ratings', '5', '4', '3', '2', '1'];
  String selectedRating = '';
  String currentRating = '';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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

      bottomNavigationBar: const NavBar(),

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
                        // ignore: prefer_interpolation_to_compose_strings
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
            // MyReviewCard(book: widget.book),
            Padding(
              padding: const EdgeInsets.all(0),
              child: FutureBuilder(
                future: fetchMyReview(request),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return SizedBox(
                      width: 320,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewFormPage(book: widget.book,),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromARGB(255, 31, 156, 35),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(5), // Rounded edges
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12), // Vertical padding
                        ),
                        child: const Text(
                          'Add Your Review',
                          style: TextStyle(
                            fontSize: 18, // Font size
                            fontWeight: FontWeight.bold, // Font weight
                          ),
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        return ReviewCard(book: widget.book, 
                          review: snapshot.data![index], 
                          isMyReview: true
                        );
                      }
                    );
                  }
                },
              ),
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: DropdownMenu<String>(
                        initialSelection: ratings.first,
                        onSelected: (String? value) {
                          setState(() {
                            currentRating = value!;
                            selectedRating = currentRating;
                            // print(selectedRating);
                          });
                        },
                        dropdownMenuEntries: ratings.map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(value: value, label: value);
                        }).toList(),
                      )
                    )
                  ],
                )
              )
            ),
            Padding(
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
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        if (selectedRating == '' || selectedRating == 'All Ratings' || snapshot.data![index].fields.rating == int.parse(selectedRating)) {
                          return ReviewCard(book: widget.book, 
                            review: snapshot.data![index], 
                            isMyReview: false
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }
                    );
                  }
                },
              ),
            )
          ],
        ),
      )
    );
  }
}