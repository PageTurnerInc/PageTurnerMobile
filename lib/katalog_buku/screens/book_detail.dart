import "package:flutter/material.dart";
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/katalog_buku/screens/katalog_buku.dart';

class BookPage extends StatelessWidget {
  final Book product;

  const BookPage(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BookCataloguePage())),
        ),
        title: const Text("Detail Buku")
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              product.fields.bookTitle
            ),
            
            Text(
              "Year of publication: ${product.fields.yearOfPublication}"
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                product.fields.bookAuthor
              )
            ),
          ],
        )
      )
    );
  }
}