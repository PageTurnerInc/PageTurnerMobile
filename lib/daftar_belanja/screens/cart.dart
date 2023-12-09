// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:page_turner_mobile/daftar_belanja/widgets/shopping_cart_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/menu/widgets/left_drawer.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  Future<List<Book>> fetchProduct(request) async {
    var response = await request.get(
        "https://pageturner-c06-tk.pbp.cs.ui.ac.id/daftar_belanja/get_shopping_cart/");

    List<Book> listShoppingCart = [];
    for (var d in response) {
      if (d != null) {
        listShoppingCart.add(Book.fromJson(d));
      }
    }
    return listShoppingCart;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      drawer: const LeftDrawer(),
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<List<Book>>(
            future: fetchProduct(request),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error fetching data');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No books in cart');
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
                    return BookCard(snapshot.data![index]);
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
