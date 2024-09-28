import 'dart:ffi';

import 'package:flutter/material.dart';

class Services {
  int id;
  String title;
  Image image;
  String? reviews;
  Float? rating;
  String description;
  List<String> price_basic;
  List<String> price_standard;
  List<String> price_premium;
  String category;
  Services(
      {required this.title,
      required this.image,
      this.reviews,
      required this.category,
      required this.description,
      required this.price_basic,
      required this.price_standard,
      required this.price_premium,
      required this.id,
      this.rating});

  static fromJson(Map<String, dynamic> json) async {
    return Services(
        title: json["title"],
        image: json["image"],
        category: json["category"],
        description: json["description"],
        price_basic: json["price_basic"],
        price_standard: json["price_standard"],
        price_premium: json["price_premium"],
        id: json["id"]);
  }
}
