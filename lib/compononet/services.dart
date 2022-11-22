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
    color: primary_color.withOpacity(0.8),
    courses: 16,
  ),
  Product(
    id: 2,
    title: "Participants",
    image: "images/part.png",
    color: primary_color.withOpacity(0.8),
    courses: 22,
  ),
  Product(
    id: 3,
    title: "UploadImage",
    image: "images/cam1.png",
    color: primary_color.withOpacity(.8),
    courses: 15,
  ),
  Product(
    id: 4,
    title: "Bills",
    image: "images/bill1.png",
    color: primary_color.withOpacity(.8),
    courses: 15,
  ),
];
