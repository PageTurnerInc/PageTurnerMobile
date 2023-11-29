import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:page_turner_mobile/rak_buku/models/rak.dart';
import 'package:page_turner_mobile/menu/models/book.dart';

import 'package:page_turner_mobile/menu/widgets/left_drawer.dart';

import 'package:page_turner_mobile/rak_buku/screens/add_library.dart';
import 'package:page_turner_mobile/rak_buku/screens/rak_buku.dart';

class DetailRakPage extends StatelessWidget {
  final Rak rak;

  const DetailRakPage(this.rak, {Key? key}) : super(key: key);

  Future<List<Book>> fetchBuku(request) async {
    var response = await request.get(
      "http://127.0.0.1:8080/rak_buku/get-rak/${rak.pk}/list-book/",
    );

    // melakukan konversi data json menjadi object Product
    List<Book> list_buku = [];
    for (var d in response) {
      if (d != null) {
        list_buku.add(Book.fromJson(d));
      }
    }
    return list_buku;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Library Detail'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Book>>(
        future: fetchBuku(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Error loading data');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text("Tidak ada data buku.");
          } else {
            return Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Handle button press
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const AddLibrary()));
                      },
                      child: const Text('Edit'),
                    ),
                    SizedBox(width: 16.0), // Add some spacing between the text and the button
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Handle button press
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const AddLibrary()));
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
                Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                            "${rak.fields.name}",
                            style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                            ),
                            ),
                            const SizedBox(height: 10),
                            Text("${rak.fields.description}"),
                            const SizedBox(height: 10),
                            Text("Created by: ${rak.fields.user}",
                            style: const TextStyle(
                                // Add your style properties if needed
                            ),
                            ),
                        ],
                        ),
                    ),
                    ),


                ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data![index].fields.bookTitle}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.bookAuthor}"),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.yearOfPublication}"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
