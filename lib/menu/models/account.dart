// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

List<Account> accountFromJson(String str) => List<Account>.from(json.decode(str).map((x) => Account.fromJson(x)));

String accountToJson(List<Account> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Account {
    String model;
    int pk;
    Fields fields;

    Account({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Account.fromJson(Map<String, dynamic> json) => Account(
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
    int user;
    String fullName;
    String email;
    String isPremium;

    Fields({
        required this.user,
        required this.fullName,
        required this.email,
        required this.isPremium,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        fullName: json["full_name"],
        email: json["email"],
        isPremium: json["is_premium"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "full_name": fullName,
        "email": email,
        "is_premium": isPremium,
    };
}
