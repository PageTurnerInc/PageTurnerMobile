// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:page_turner_mobile/menu/screens/menu.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class CheckoutFormPage extends StatefulWidget {
  const CheckoutFormPage({super.key});

  @override
  State<CheckoutFormPage> createState() => _CheckoutFormPageState();
}

class _CheckoutFormPageState extends State<CheckoutFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = "";
  List<String> paymentMethod = [
    "Debit Card",
    "Credit Card",
    "GoPay",
    "OVO",
    "PayPal"
  ];
  String _payment = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    _payment = paymentMethod.first;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Checkout Cart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Who do you want to buy this for?",
                  labelText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _username = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Username cannot be empty!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Payment Method',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                value: _payment,
                items:
                    paymentMethod.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _payment = newValue!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Choose your payment method!";
                  }
                  return null;
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Rounded edges
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12), // Vertical padding
                    ),
                    child: const Text(
                      'Confirm Payment',
                      style: TextStyle(
                        fontSize: 18, // Font size
                        fontWeight: FontWeight.bold, // Font weight
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                            "https://pageturner-c06-tk.pbp.cs.ui.ac.id/daftar_belanja/confirm_payment_flutter/",
                            jsonEncode(<String, String>{
                              'username': _username.toString(),
                              'payment': _payment.toString(),
                            }));
                        ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            content: Text(response["message"].toString()),
                          ));
                        if (response['status'] == true) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

  

// void _showCheckout(BuildContext context, request) async {
//     List<Book> books =
//         await fetchProduct(request); // Fetch the products if not already done

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return FutureBuilder<List<Book>>(
//             future: fetchProduct(request),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const CircularProgressIndicator();
//               } else if (snapshot.hasError) {
//                 return const Text('Error fetching books');
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return const Text('No books in cart');
//               }
//               return Dialog(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: Form(
//                   key: _formKey,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         AppBar(
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(10.0),
//                               topRight: Radius.circular(10.0),
//                             ),
//                           ),
//                           automaticallyImplyLeading: false,
//                           title: const Text(
//                             "Checkout Cart",
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.normal),
//                           ),
//                           actions: [
//                             IconButton(
//                               icon: const Icon(Icons.close),
//                               onPressed: () => Navigator.pop(context),
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Column(
//                             children: [
//                               const Text(
//                                 "Please confirm your receipt",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontSize: 20, fontWeight: FontWeight.bold),
//                               ),
//                               const SizedBox(height: 20),
//                               DataTable(
//                                 columns: const [
//                                   DataColumn(label: Text('Title')),
//                                   DataColumn(label: Text('ISBN')),
//                                 ],
//                                 rows: books
//                                     .map(
//                                       (book) => DataRow(
//                                         cells: [
//                                           DataCell(Text(book.fields.bookTitle)),
//                                           DataCell(Text(book.fields.isbn)),
//                                         ],
//                                       ),
//                                     )
//                                     .toList(),
//                               ),
//                               const SizedBox(height: 20),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             });
//       },
//     );
//   }