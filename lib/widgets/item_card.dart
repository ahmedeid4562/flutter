import 'package:flutter/material.dart';
import '../model/product.dart';
import '../screens/product_detail_screen.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;
  final double? width;
  final List<Product> favourites;
  final Function(Product) onToggleFavourite;

  const ItemCard({super.key,  required this.product,required this.onAdd, this.width,required this.favourites, required this.onToggleFavourite,});

  @override
  Widget build(BuildContext context) {
    final bool isFavourite = favourites.contains(product);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductDetailScreen(
                product: product,
                onAddToCart: (p) => onAdd(),
              );
            },
          ),
        );
      },
      child: Container(
        width: width ?? 175,
        height: 250,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xffE2E2E2),
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    product.image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.shopping_bag,
                      size: 50,
                      color: Color(0xff53B175),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff181725),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  product.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff7C7C7C),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff181725),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 42,
                      height: 42,
                      child: FloatingActionButton(
                        onPressed: onAdd,
                        backgroundColor: const Color(0xff53B175),
                        elevation: 0,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  onToggleFavourite(product);
                },
                child: Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: isFavourite ? Colors.red : const Color(0xff7C7C7C),
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

