import 'package:flutter/material.dart';
import 'package:page_turner_mobile/daftar_belanja/widgets/navbar.dart';
import 'package:page_turner_mobile/menu/models/account.dart';
import 'package:page_turner_mobile/menu/widgets/menu_card.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<MenuItem> items = [
    MenuItem("Catalogue", Colors.indigo, Icons.library_add),
    MenuItem("Shopping Cart", Colors.indigo, Icons.shopping_cart),
    MenuItem("My Books", Colors.indigo, Icons.checklist),
    MenuItem("Library", Colors.indigo, Icons.play_arrow_rounded),
    MenuItem("Wishlist", Colors.indigo, Icons.list),
    MenuItem("Logout", const Color.fromARGB(255, 205, 28, 28), Icons.logout),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    String isPremium = "Regular Account";
    if (currentUser.isPremium == "Y") isPremium = "Premium Account";

    return Scaffold(
      bottomNavigationBar: const NavBar(),
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
                  height: screenHeight * 0.45,
                ),
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.45,
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
                    const Text(
                      'Page Turner',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Welcome ${currentUser.fullName}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isPremium,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            GridView.count(
              primary: true,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              shrinkWrap: true,
              children: items.map((MenuItem item) {
                return MenuCard(item);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
