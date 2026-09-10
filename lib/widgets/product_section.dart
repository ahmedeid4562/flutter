import 'package:flutter/material.dart';

import '../model/product.dart';

import 'item_card.dart';

class ProductSection extends StatefulWidget {
  final String title;
  final bool showSeeAll;
  final List<Product> products;
  final Function(Product) onAdd;
  final bool showArrow;
  final List<Product> favourites;
  final Function(Product) onToggleFavourite;

  const ProductSection({ super.key,   required this.title,   required this.showSeeAll,   required this.products,   required this.onAdd,   this.showArrow = true,   required this.favourites,   required this.onToggleFavourite, });

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  final ScrollController scrollController = ScrollController();

  void moveRight() {
    if (!scrollController.hasClients) {
      return;
    }

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentPosition = scrollController.offset;

    double newPosition = currentPosition + 360;

    if (newPosition > maxScroll) {
      newPosition = maxScroll;
    }

    scrollController.animateTo(
      newPosition,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {   scrollController.dispose();   super.dispose(); }

  @override
  Widget build(BuildContext context) {
    if (widget.products.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff181725),
                ),
              ),
              if (widget.showSeeAll)
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
        if (widget.title.isNotEmpty)
          const SizedBox(height: 15),
        SizedBox(
          height: 250,
          child: Row(
            children: [
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.products.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 15);
                  },
                  itemBuilder: (context, index) {
                    final product = widget.products[index];

                    return ItemCard(
                      product: product,
                      width: 173,
                      onAdd: () {
                        widget.onAdd(product);
                      },
                      favourites: widget.favourites,
                      onToggleFavourite: widget.onToggleFavourite,
                    );
                  },
                ),
              ),
              if (widget.showArrow) ...[
                const SizedBox(width: 3),
                IconButton(
                  onPressed: moveRight,
                  icon: const Text(
                    ">",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff53B175),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

