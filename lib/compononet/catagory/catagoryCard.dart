import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.product,
    required this.onmyTap,
    required this.pageName,
  }) : super(key: key);
  final Product product;
  final String pageName;
  final Function() onmyTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onmyTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: product.color, borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            children: [
              Image.asset(
                product.image,
                height: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                product.title,
                style: GoogleFonts.aclonica(
                    textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
