// To parse this JSON data, do
//
//     final shoppingCart = shoppingCartFromJson(jsonString);

import 'dart:convert';

List<ShoppingCart> shoppingCartFromJson(String str) => List<ShoppingCart>.from(json.decode(str).map((x) => ShoppingCart.fromJson(x)));

String shoppingCartToJson(List<ShoppingCart> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShoppingCart {
    String model;
    int pk;
    Fields fields;

    ShoppingCart({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory ShoppingCart.fromJson(Map<String, dynamic> json) => ShoppingCart(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int account;
    List<int> cart;
    List<int> ownedBooks;

    Fields({
        required this.account,
        required this.cart,
        required this.ownedBooks,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        account: json["account"],
        cart: List<int>.from(json["cart"].map((x) => x)),
        ownedBooks: List<int>.from(json["owned_books"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "account": account,
        "cart": List<dynamic>.from(cart.map((x) => x)),
        "owned_books": List<dynamic>.from(ownedBooks.map((x) => x)),
    };
}
