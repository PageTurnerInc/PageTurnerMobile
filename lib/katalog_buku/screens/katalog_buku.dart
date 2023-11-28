import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:page_turner_mobile/menu/models/book.dart';
import 'package:page_turner_mobile/menu/widgets/left_drawer.dart';
import 'package:page_turner_mobile/katalog_buku/screens/book_detail.dart';


class BookCataloguePage extends StatefulWidget {
    const BookCataloguePage({Key? key}) : super(key: key);

    @override
    // ignore: library_private_types_in_public_api
    _BookCataloguePageState createState() => _BookCataloguePageState();
}

class _BookCataloguePageState extends State<BookCataloguePage> {
    
    Future<List<Book>> fetchProduct() async {
        var url = Uri.parse(
          "https://pageturner-c06-tk.pbp.cs.ui.ac.id/katalog/json/"
        );
        var response = await http.get(
            url,
            headers: {"Content-Type": "application/json"},
        );

        // melakukan decode response menjadi bentuk json
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        // melakukan konversi data json menjadi object Product
        List<Book> listProduct = [];
        for (var d in data) {
            if (d != null) {
                listProduct.add(Book.fromJson(d));
            }
        }
        return listProduct;
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Product'),
          ),
          drawer: const LeftDrawer(),
          body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
              
              if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
              } 
              
              else {
                if (!snapshot.hasData) {

                  return const Column(
                    children: [
                      Text(
                          "Tidak ada data produk.",
                          style:
                              TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      
                      SizedBox(height: 8),
                    ],
                  );
                } 
                
                else {

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Container(
                      margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context,
                          MaterialPageRoute(
                            builder: (context) => BookPage(snapshot.data![index])));
                        },

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              "${snapshot.data![index].fields.name}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            
                            const SizedBox(height: 10),
                            
                            Text("Tersedia ${snapshot.data![index].fields.amount} Buah"),
                            
                            const SizedBox(height: 10),
                            
                            Text("${snapshot.data![index].fields.description}")
                          ],
                        )
                      )
                    )
                  );
                }
              }
            }
          )
      );
    }
}
