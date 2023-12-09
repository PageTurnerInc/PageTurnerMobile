// // ignore_for_file: use_build_context_synchronously, must_be_immutable, library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:page_turner_mobile/daftar_belanja/screens/shopping_cart.dart';
// import 'package:page_turner_mobile/daftar_belanja/screens/owned_books.dart';
// import 'package:page_turner_mobile/katalog_buku/screens/katalog_buku.dart';
// import 'package:page_turner_mobile/menu/models/account.dart';
// import 'package:page_turner_mobile/menu/screens/menu.dart';
// import 'package:page_turner_mobile/wishlist/screens/wishlist_items.dart';

// class NavBar extends StatefulWidget {
//   const NavBar({super.key});

//   @override
//   _NavBarState createState() => _NavBarState();
// }

// class _NavBarState extends State<NavBar> {
//   void _onItemTapped(BuildContext context, index) {
//     setState(() {
//       currentPage = index;
//     });

//     switch (index) {
//       case 0:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => MyHomePage()),
//         );
//         break;
//       case 1:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const BookCataloguePage()),
//         );
//         break;
//       case 2:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const ShoppingCartPage()),
//         );
//         break;
//       case 3:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const OwnedBooksPage()),
//         );
//         break;
//       case 4:
//         // Move to wishlist
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const WishlistPage()),
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       // color: ,
//       shape: const CircularNotchedRectangle(),
//       notchMargin: 4.0,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           // Home
//           IconButton(
//             icon: const Icon(Icons.home_outlined),
//             onPressed: () => _onItemTapped(context, 0),
//             color: currentPage == 0 ? const Color.fromARGB(255, 33, 44, 243) : null,
//           ),
//           // Catalogue
//           IconButton(
//             icon: const Icon(Icons.library_add),
//             onPressed: () => _onItemTapped(context, 1),
//             color: currentPage == 1 ? const Color.fromARGB(255, 33, 44, 243) : null,
//           ),
//           // Shopping Cart
//           IconButton(
//             icon: const Icon(Icons.shopping_cart),
//             onPressed: () => _onItemTapped(context, 2),
//             color: currentPage == 2 ? const Color.fromARGB(255, 33, 44, 243) : null,
//           ),
//           // My Books
//           IconButton(
//             icon: const Icon(Icons.checklist),
//             onPressed: () => _onItemTapped(context, 3),
//             color: currentPage == 3 ? const Color.fromARGB(255, 33, 44, 243) : null,
//           ),
//           // Wishlist
//           IconButton(
//             icon: const Icon(Icons.list),
//             onPressed: () => _onItemTapped(context, 4),
//             color: currentPage == 4 ? const Color.fromARGB(255, 33, 44, 243) : null,
//           ),
//         ],
//       ),
//     );
//   }
// }
