// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:page_turner_mobile/wishlist/screens/notes_form.dart';
import 'package:page_turner_mobile/wishlist/screens/show_notes.dart';
import 'package:page_turner_mobile/wishlist/widgets/wishlist_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:page_turner_mobile/wishlist/models/wishlist.dart';
import 'package:page_turner_mobile/daftar_belanja/widgets/navbar.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  Future<List<Wishlist>> fetchProduct(request) async {
    var response = await request.get(
        "https://pageturner-c06-tk.pbp.cs.ui.ac.id/wishlist/get_wishlist_items/");

    List<Wishlist> wishlistItems = [];
    for (var d in response) {
      if (d != null) {
        print(Wishlist.fromJson(d));
        wishlistItems.add(Wishlist.fromJson(d));
      }
    }
    return wishlistItems;
  }

  void _addNotes() {
    print("Add Notes clicked");
    // Add your functionality for adding notes
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotesFormPage(),
      ),
    );
  }

  void _viewNotes() {
    print("View Notes clicked");
    // Add your functionality for viewing notes
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotesPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      bottomNavigationBar: const NavBar(),
      appBar: AppBar(
        title: const Text('Wishlist'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.note_add),
            onPressed: _addNotes,
            tooltip: 'Add Notes',
          ),
          IconButton(
            icon: const Icon(Icons.notes),
            onPressed: _viewNotes,
            tooltip: 'View Notes',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<List<Wishlist>>(
            future: fetchProduct(request),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No books in wishlist');
              } else {
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
                    return WishlistCard(snapshot.data![index]);
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
