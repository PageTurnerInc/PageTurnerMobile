// To parse this JSON data, do
//
//     final bookRating = bookRatingFromJson(jsonString);

import 'dart:convert';

BookRating bookRatingFromJson(String str) => BookRating.fromJson(json.decode(str));

String bookRatingToJson(BookRating data) => json.encode(data.toJson());

class BookRating {
    String model;
    int pk;
    Fields fields;

    BookRating({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory BookRating.fromJson(Map<String, dynamic> json) => BookRating(
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
    double rating;

    Fields({
        required this.rating,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        rating: json["rating"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "rating": rating,
    };
}
