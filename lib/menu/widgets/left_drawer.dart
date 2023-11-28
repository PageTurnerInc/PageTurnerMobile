// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:page_turner_mobile/daftar_belanja/screens/cart.dart';
import 'package:page_turner_mobile/daftar_belanja/screens/owned_books.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:page_turner_mobile/menu/screens/login.dart';
import 'package:page_turner_mobile/menu/screens/menu.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Column(
              children: [
                Text(
                  'Page Turner',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "What would you like to do today?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Bagian redirection ke MyHomePage
            onTap: () async {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text('Catalogue'),
            // Bagian redirection ke ShopFormPage
            onTap: () async {
              
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('My Books'),
            // Bagian redirection ke ShopFormPage
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OwnedBooksPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Shopping Cart'),
            // Bagian redirection ke ShopFormPage
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShoppingCartPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Library'),
            // Bagian redirection ke ShopFormPage
            onTap: () async {
              
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Wishlist'),
            // Bagian redirection ke ShopFormPage
            onTap: () async {
              
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            // Bagian redirection ke ShopFormPage
            onTap: () async {
              final response = await request.logout(
                "https://pageturner-c06-tk.pbp.cs.ui.ac.id/auth/logout/"
              );
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
            },
          ),
        ],
      ),
    );
  }
}