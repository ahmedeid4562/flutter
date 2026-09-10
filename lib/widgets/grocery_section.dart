import 'package:flutter/material.dart';

import 'grocery_card.dart';

class GrocerySection extends StatelessWidget {
  const GrocerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Groceries",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xff181725),
              ),
            ),
            const Text(
              "See all",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff53B175),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              GroceryCard(
                image: "assets/images/image1.png",
                title: "Pulses",
                color: const Color(0xffF8F2E8),
              ),
              const SizedBox(width: 15),
              GroceryCard(
                image: "assets/images/image2.png",
                title: "Rice",
                color: const Color(0xffE8F5E9),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

