// To parse this JSON data, do
//
//     final wishlist = wishlistFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

List<Wishlist> wishlistFromJson(String str) => List<Wishlist>.from(json.decode(str).map((x) => Wishlist.fromJson(x)));

String wishlistToJson(List<Wishlist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Wishlist {
    String imageUrlL;
    String bookTitle;
    String bookAuthor;
    int yearOfPublication;
    String publisher;
    int pk;

    Wishlist({
        required this.imageUrlL,
        required this.bookTitle,
        required this.bookAuthor,
        required this.yearOfPublication,
        required this.publisher,
        required this.pk,
    });

    factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        imageUrlL: json["image_url_l"],
        bookTitle: json["book_title"],
        bookAuthor: json["book_author"],
        yearOfPublication: json["year_of_publication"],
        publisher: json["publisher"],
        pk: json["pk"],
    );

    Map<String, dynamic> toJson() => {
        "image_url_l": imageUrlL,
        "book_title": bookTitle,
        "book_author": bookAuthor,
        "year_of_publication": yearOfPublication,
        "publisher": publisher,
        "pk": pk,
    };
}
