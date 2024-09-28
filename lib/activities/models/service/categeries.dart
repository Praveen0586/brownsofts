import 'package:flutter/material.dart';

class Categeries {
  String titles;
  String image;
  Categeries({required this.image, required this.titles});
}

List<Categeries> appCategory = [
  Categeries(
      titles: "Video & Animation",
      image:
          "https://brownsofts.com/assets/img/service-categories/66727d8ab29c5.png"),
  Categeries(
      image:
          "https://brownsofts.com/assets/img/service-categories/66727d65bb6e8.jpg",
      titles: "Web Design"),
  Categeries(
      image:
          "https://brownsofts.com/assets/img/service-categories/66727e0901c87.jpg",
      titles: "Graphics & Design"),
  Categeries(
      image:
          "https://brownsofts.com/assets/img/service-categories/66727db64027b.jpg",
      titles: "SEO & Marketting"),
  Categeries(
      image:
          "https://brownsofts.com/assets/img/service-categories/66727d55b9966.jpg",
      titles: "Admin Support")
];
