// To parse this JSON data, do
//
//     final Rak = RakFromJson(jsonString);

import 'dart:convert';

List<Rak> rakToJson(String str) => List<Rak>.from(json.decode(str).map((x) => Rak.fromJson(x)));

String rakToJson(List<Rak> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rak {
    String model;
    int pk;
    Fields fields;

    Rak({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Rak.fromJson(Map<String, dynamic> json) => Rak(
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
    String name;
    String description;
    int user;
    List<int> books;

    Fields({
        required this.name,
        required this.description,
        required this.user,
        required this.books,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        description: json["description"],
        user: json["user"],
        books: List<int>.from(json["books"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "user": user,
        "books": List<dynamic>.from(books.map((x) => x)),
    };
}