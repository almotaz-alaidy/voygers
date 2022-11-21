import 'package:flutter/material.dart';
import 'package:voygares/compononet/colors.dart';

class Product {
  final String image, title;
  final int id, courses;
  final Color color;
  Product({
    required this.image,
    required this.title,
    required this.courses,
    required this.color,
    required this.id,
  });
}

List<Product> products = [
  Product(
    id: 1,
    title: "Trip Details ",
    image: "images/voyage.png",
    color: primary_color,
    courses: 16,
  ),
  Product(
    id: 2,
    title: "Participants",
    image: "images/participant1.jpg",
    color: primary_color,
    courses: 22,
  ),
  Product(
    id: 3,
    title: "UploadImage",
    image: "images/uploed image3.webp",
    color: primary_color,
    courses: 15,
  ),
  Product(
    id: 4,
    title: "Bills",
    image: "images/bills.jpg",
    color: primary_color,
    courses: 15,
  ),
];
