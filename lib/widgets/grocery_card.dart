// الكارت ده بيعرض صورة واسم قسم من أقسام المنتجات داخل التطبيق.
import 'package:flutter/material.dart';

class GroceryCard extends StatelessWidget {
  final String image;
  final String title;
  final Color color;

  const GroceryCard({    super.key,    required this.image,    required this.title,    required this.color,  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const SizedBox(width: 15),
          Image.asset(
            image,
            width: 70,
            height: 70,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff181725),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

