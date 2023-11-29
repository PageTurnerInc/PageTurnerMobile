// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:page_turner_mobile/menu/screens/login.dart';
import 'package:page_turner_mobile/katalog_buku/screens/katalog_buku.dart';
import 'package:page_turner_mobile/daftar_belanja/screens/cart.dart';
import 'package:page_turner_mobile/daftar_belanja/screens/owned_books.dart';
import 'package:page_turner_mobile/wishlist/screens/wishlist_items.dart';

class MenuItem {
  final String name;
  final Color color;
  final IconData icon;

  MenuItem(this.name, this.color, this.icon);
}

class MenuCard extends StatelessWidget {
  final MenuItem item;

  const MenuCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () async {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
            );
          
          if (item.name == "Catalogue") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BookCataloguePage())
            );
          }
          else if (item.name == "My Books") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OwnedBooksPage(),
              ),
            );
          } 
          else if (item.name == "Shopping Cart") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShoppingCartPage(),
              ),
            );
          } 
          else if (item.name == "Library") {

          } 
          else if (item.name == "Wishlist") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WishlistPage(),
              ),
            );
            
          }

          else if (item.name == "Logout") {
            final response = await request.logout(
                "https://pageturner-c06-tk.pbp.cs.ui.ac.id/auth/logout/");
            String message = response["message"];
            if (response['status']) {
              String uname = response["username"];
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message Sampai jumpa, $uname."),
              ));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message),
              ));
            }
          }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
