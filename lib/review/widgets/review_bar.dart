import 'package:flutter/material.dart';
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/review/screens/review_list.dart';
import 'package:page_turner_mobile/review/widgets/book_rate_widget.dart';

class ReviewBar extends StatefulWidget {
  final Book book;

  const ReviewBar({required this.book, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ReviewBarState createState() => _ReviewBarState();
}

class _ReviewBarState extends State<ReviewBar> {
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reviews & Ratings',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Icon(
                  Icons.arrow_forward,
                  color: Colors.blue,
                )
              ],
            ),
            const SizedBox(height: 6,),
            BookRate(book: widget.book, isReviewList: false)
          ],
        ),
      ),
    );
  }
}
