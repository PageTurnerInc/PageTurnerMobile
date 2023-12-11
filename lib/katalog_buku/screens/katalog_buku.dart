import 'package:flutter/material.dart';
import 'package:page_turner_mobile/katalog_buku/widgets/book_card.dart';
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/menu/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookCataloguePage extends StatefulWidget {
    const BookCataloguePage({Key? key}) : super(key: key);

    @override
    // ignore: library_private_types_in_public_api
    _BookCataloguePageState createState() => _BookCataloguePageState();
}

class _BookCataloguePageState extends State<BookCataloguePage> {
  Future<List<Book>> fetchProduct(request) async {
    var response = await request.get(
      "https://pageturner-c06-tk.pbp.cs.ui.ac.id/katalog/json/"
    );

    List<Book> listOwnedBooks = [];
    for (var d in response) {
      if (d != null) {
        listOwnedBooks.add(Book.fromJson(d));
      }
    }
    return listOwnedBooks;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      drawer: const LeftDrawer(),
      appBar: AppBar(
        title: const Text('Catalogue'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<List<Book>>(
            future: fetchProduct(request),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } 
              else if (snapshot.hasError) {
                return const Text('Error fetching data');
              } 
              else {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1 / 2,
                  ),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return BookDetailCard(snapshot.data![index]);
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
