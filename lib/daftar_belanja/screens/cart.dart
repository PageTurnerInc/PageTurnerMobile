// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:page_turner_mobile/menu/widgets/left_drawer.dart';
import 'package:page_turner_mobile/daftar_belanja/models/book_temp.dart';

class ShoppingCartPage extends StatelessWidget {
  ShoppingCartPage({Key? key}) : super(key: key);

  final List<Book> books = [
    Book("Nights Below Station Street", "David Adams Richards", "Emblem Editions"),
    Book("Hitler's Secret Bankers: The Myth of Swiss Neutrality During the Holocaust", "Adam Lebor", "Citadel Press"),
    Book("A Second Chicken Soup for the Woman's Soul (Chicken Soup for the Soul Series)", "Jack Canfield", "Health Communications"),
    Book("Haveli (Laurel Leaf Books)", "SUZANNE FISHER STAPLES", "Laurel Leaf"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LeftDrawer(),
      appBar: AppBar(
        title: const Text(
          'Shopping Cart',
        ),
      ),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Page Turner', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: books.map((Book book) {
                  // Iterasi untuk setiap item
                  return BookCard(book);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}









































// class ShoppingCartPage extends StatefulWidget {
//     const ShoppingCartPage({Key? key}) : super(key: key);

//     @override
//     _ShoppingCartPageState createState() => _ShoppingCartPageState();
// }

// class _ShoppingCartPageState extends State<ShoppingCartPage> {
// Future<List<Book>> fetchItem() async {
//     // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
//     var url = Uri.parse(
//         'https://pageturner-c06-tk.pbp.cs.ui.ac.id/daftar_belanja/get_shopping_cart/');
//     var response = await http.get(
//         url,
//         headers: {"Content-Type": "application/json"},
//     );

//     // melakukan decode response menjadi bentuk json
//     var data = jsonDecode(utf8.decode(response.bodyBytes));

//     // melakukan konversi data json menjadi object Item
//     List<Book> shopping_cart = [];
//     for (var d in data) {
//         if (d != null) {
//             shopping_cart.add(Book.fromJson(d));
//         }
//     }
//     return shopping_cart;
// }

// @override
// Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//         title: const Text('Shopping Cart'),
//         ),
//         drawer: const LeftDrawer(),
//         body: FutureBuilder(
//             future: fetchItem(),
//             builder: (context, AsyncSnapshot snapshot) {
//                 if (snapshot.data == null) {
//                     return const Center(child: CircularProgressIndicator());
//                 } else {
//                     if (!snapshot.hasData) {
//                       return const Column(
//                           children: [
//                           Text(
//                               "Tidak ada data produk.",
//                               style:
//                                   TextStyle(color: Color(0xff59A5D8), fontSize: 20),
//                           ),
//                           SizedBox(height: 8),
//                           ],
//                       );
//                     } else {
//                         return ListView.builder(
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (_, index) => Container(
//                                   margin: const EdgeInsets.symmetric(
//                                       horizontal: 16, vertical: 12),
//                                   padding: const EdgeInsets.all(20.0),
//                                   child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                       Text(
//                                       "${snapshot.data![index].fields.name}",
//                                       style: const TextStyle(
//                                           fontSize: 18.0,
//                                           fontWeight: FontWeight.bold,
//                                       ),
//                                       ),
//                                       const SizedBox(height: 10),
//                                       Text("${snapshot.data![index].fields.bookTitle}"),
//                                       const SizedBox(height: 10),
//                                       Text("${snapshot.data![index].fields.isbn}"),
//                                       const SizedBox(height: 10),
//                                       Text("${snapshot.data![index].fields.bookAuthor}"),
//                                       const SizedBox(height: 10),
//                                       Text(
//                                           "${snapshot.data![index].fields.publisher}"
//                                       ),
//                                   ],
//                                   ),
//                               )
//                         );
//                       }
//                 }
//             }));
//     }
// }