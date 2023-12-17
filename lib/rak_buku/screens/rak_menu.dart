import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:page_turner_mobile/rak_buku/models/rak.dart';
import 'package:page_turner_mobile/rak_buku/screens/add_library.dart';
import 'package:page_turner_mobile/rak_buku/screens/rak_buku.dart';
import 'package:page_turner_mobile/rak_buku/screens/rak_rekomendasi.dart';
import 'package:page_turner_mobile/daftar_belanja/widgets/navbar.dart';
import 'package:page_turner_mobile/menu/models/account.dart';

class RakPage extends StatefulWidget {
  const RakPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RakPageState createState() => _RakPageState();
}

class _RakPageState extends State<RakPage> {
  Future<List<Rak>> fetchRak(request) async {
    var response = await request
        .get("https://pageturner-c06-tk.pbp.cs.ui.ac.id/rak_buku/get-rak/");

    List<Rak> listRak = [];
    for (var d in response) {
      if (d != null) {
        listRak.add(Rak.fromJson(d));
      }
    }
    return listRak;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    String isPremium = "Regular Account";
    if (currentUser.isPremium == "Y") isPremium = "Premium Account";

    return Scaffold(
      bottomNavigationBar: const NavBar(),
      body: FutureBuilder<List<Rak>>(
        future: fetchRak(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return const Column(
              children: [
                Text(
                  "Tidak ada data rak.",
                  style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                ),
                SizedBox(height: 8),
              ],
            );
          } else {
            return Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/shopping_cart_bg.webp',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
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
                          'Your Library',
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
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Your Library",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddLibrary()));
                      },
                      child: const Text('Add New Library'),
                    ),
                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RakRecommendPage()));
                      },
                      child: const Text('Recommendation'),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailRakPage(snapshot.data![index]),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 100, // Set a fixed height for the container
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Padding(
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
