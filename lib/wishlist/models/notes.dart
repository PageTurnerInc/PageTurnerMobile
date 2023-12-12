// To parse this JSON data, do
//
//     final Notes = NotesFromJson(jsonString);

import 'dart:convert';

List<Notes> notesFromJson(String str) => List<Notes>.from(json.decode(str).map((x) => Notes.fromJson(x)));

String notesToJson(List<Notes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notes {
    String model;
    int pk;
    Fields fields;

    Notes({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Notes.fromJson(Map<String, dynamic> json) => Notes(
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
    String title;
    String notes;
    int user;

    Fields({
        required this.title,
        required this.notes,
        required this.user,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        notes: json["notes"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "notes": notes,
        "user": user,
    };
}