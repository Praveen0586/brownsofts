import 'package:flutter/material.dart';

class Categeries {
  String titles;
  AssetImage image;
  Categeries({required this.image, required this.titles});
}

List<Categeries> appCategory = [
  Categeries(titles: "Video & Animation", image: AssetImage("assets/avd.jpg")),
  Categeries(image: AssetImage("assets/WED.jpg"), titles: "Web Design"),
  Categeries(image: AssetImage("assets/GPH.webp"), titles: "Graphics & Design"),
  Categeries(image: AssetImage("assets/seo.jpg"), titles: "SEO & Marketting"),
  Categeries(image: AssetImage("assets/asas.jpg"), titles: "Admin Support")
];
