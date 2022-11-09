import 'package:flutter/material.dart';

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
    image: "images/1.png",
    color: Color.fromARGB(144, 7, 211, 20),
    courses: 16,
  ),
  Product(
    id: 2,
    title: "Participants",
    image: "images/2.jpg",
    color: Color.fromARGB(144, 7, 211, 20),
    courses: 22,
  ),
  Product(
    id: 3,
    title: "UploadImage",
    image: "images/3.png",
    color: Color.fromARGB(144, 7, 211, 20),
    courses: 15,
  ),
  Product(
    id: 4,
    title: "Bills",
    image: "images/4.jpg",
    color: Color.fromARGB(144, 7, 211, 20),
    courses: 15,
  ),
];
