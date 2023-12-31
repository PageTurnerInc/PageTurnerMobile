import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_turner_mobile/daftar_belanja/widgets/navbar.dart';
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/review/screens/review_list.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewFormPage extends StatefulWidget {
  final Book book;

  const ReviewFormPage({required this.book, Key? key}) : super(key: key);

  @override
  State<ReviewFormPage> createState() => _ReviewFormPageState();
}

class _ReviewFormPageState extends State<ReviewFormPage> {
  final _formKey = GlobalKey<FormState>();

  int _rating = 0;
  String _comment = "";
  int _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Your Review',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReviewsPage(book: widget.book),
              ),
            );
          },
        )
      ),
      bottomNavigationBar: const NavBar(),
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      // Menentukan warna bintang berdasarkan rating
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentRating = index + 1;
                            _rating = _currentRating;
                            // print(_rating);
                          });
                        },
                        child: Icon(
                          Icons.star,
                          color: index < _currentRating
                              ? Colors.blue
                              : Colors.grey,
                          size: 50,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "Describe Your Experience (Optional)",
                          labelText: "Describe Your Experience (Optional)",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            if (value == null || value.isEmpty) {
                              _comment = "";
                            } else {
                              _comment = value;
                            }
                          });
                        }),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                        ),
                        onPressed: () async {
                          if (_rating == 0) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Rating cannot be 0"),
                            ));
                          } else if (_formKey.currentState!.validate()) {
                            // Kirim ke Django dan tunggu respons
                            // DONE: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                            final response = await request.postJson(
                                "https://pageturner-c06-tk.pbp.cs.ui.ac.id/review/create-review-flutter/${widget.book.pk}/",
                                jsonEncode(<String, String>{
                                  'rating': _rating.toString(),
                                  'comment': _comment,
                                }));
                            if (response['status'] == 'success') {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Review has been created!"),
                              ));
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReviewsPage(
                                          book: widget.book,
                                        )),
                              );
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("ERROR, please try again!"),
                              ));
                            }
                          }
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
