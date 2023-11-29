import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:page_turner_mobile/rak_buku/models/rak.dart';
import 'package:page_turner_mobile/menu/widgets/left_drawer.dart';
import 'package:page_turner_mobile/rak_buku/screens/add_library.dart';

class RakPage extends StatefulWidget {
  const RakPage({Key? key}) : super(key: key);

  @override
  _RakPageState createState() => _RakPageState();
}

class _RakPageState extends State<RakPage> {
  Future<List<Rak>> fetchRak(request) async {
    var response = await request.get(
      "https://pageturner-c06-tk.pbp.cs.ui.ac.id/rak_buku/get-rak/"
    );


    // melakukan konversi data json menjadi object Product
    List<Rak> list_rak = [];
    for (var d in request) {
      if (d != null) {
        list_rak.add(Rak.fromJson(d));
      }
    }
    return list_rak;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rak'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchRak(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } 
          else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Column(
              children: [
                Text(
                  "Tidak ada data rak.",
                  style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                ),
                SizedBox(height: 8),
              ],
            );
          } 
          else {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    //Navigator.push(
                    //context,
                    //MaterialPageRoute(builder: (context) => AddLibraryScreen()),
                    //);
                },
                  child: const Text('Add New Library'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      padding: const EdgeInsets.all(20.0),
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
