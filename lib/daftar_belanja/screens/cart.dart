// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:page_turner_mobile/daftar_belanja/widgets/shopping_cart_card.dart';
import 'package:page_turner_mobile/menu/models/account.dart';
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
    var response = await request
        .get("http://127.0.0.1:8080/daftar_belanja/get_shopping_cart/");

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

    String isPremium = "Regular Account";
    if (currentUser.isPremium == "Y") isPremium = "Premium Account";

    return Scaffold(
      drawer: const LeftDrawer(),
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
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
                      'Shopping Cart',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Welcome ${currentUser.fullName}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      isPremium,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Padding(
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
          ],
        ),
      ),
    );
  }
}
