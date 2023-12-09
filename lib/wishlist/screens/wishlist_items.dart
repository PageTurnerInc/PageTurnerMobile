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


  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      bottomNavigationBar: const NavBar(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotesFormPage(),
                ),
              );
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            child: Icon(Icons.note_add),
            heroTag: null,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotesPage(),
                ),
              );
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            child: Icon(Icons.view_list),
            heroTag: null,
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
               alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/shopping_cart_bg.webp',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200, // Adjust the height as needed
                ),
                Container(
                  width: double.infinity,
                  height: 200, // Ensure this matches the image's height
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
                      'Wishlist',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Padding(
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
          ],
        )
        
        
      ),
    );
  }
}
