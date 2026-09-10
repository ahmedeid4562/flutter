import 'package:flutter/material.dart';
import '../model/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final Function(Product) onAddToCart;

  const ProductDetailScreen({  super.key,  required this.product,  required this.onAddToCart,});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  bool isFavorite = false;
  bool isDetailExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                color: Color(0xffF2F3F2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xff181725),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(
                        Icons.ios_share,
                        color: Color(0xff181725),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Image.asset(
                        widget.product.image,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.shopping_bag,
                          size: 100,
                          color: Color(0xff53B175),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 16,
                          height: 3,
                          decoration: BoxDecoration(
                            color: const Color(0xff53B175),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 4),
                        ...List.generate(
                          2,
                          (_) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Container(
                              width: 3,
                              height: 3,
                              decoration: const BoxDecoration(
                                color: Color(0xffB3B3B3),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff181725),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavorite
                                ? Colors.red
                                : const Color(0xff7C7C7C),
                            size: 26,
                          ),
                          onPressed: () => setState(
                            () => isFavorite = !isFavorite,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.product.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff7C7C7C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (quantity > 1) {
                              setState(() => quantity--);
                            }
                          },
                          child: const Icon(
                            Icons.remove,
                            color: Color(0xffB3B3B3),
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Container(
                          width: 45,
                          height: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffE2E2E2),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            '$quantity',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff181725),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        InkWell(
                          onTap: () => setState(() => quantity++),
                          child: const Icon(
                            Icons.add,
                            color: Color(0xff53B175),
                            size: 28,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${(widget.product.price * quantity).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff181725),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Color(0xffE2E2E2)),
                    InkWell(
                      onTap: () => setState(
                        () => isDetailExpanded = !isDetailExpanded,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Product Detail",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff181725),
                              ),
                            ),
                            Icon(
                              isDetailExpanded
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_right,
                              color: const Color(0xff181725),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isDetailExpanded)
                      const Text(
                        "Apples Are Nutritious. Apples May Be Good For Weight Loss. Apples May Be Good For Your Heart. As Part Of A Healthful And Varied Diet.",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff7C7C7C),
                          height: 1.4,
                        ),
                      ),
                    const Divider(color: Color(0xffE2E2E2)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          const Text(
                            "Nutritons",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff181725),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffE2E2E2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "100gr",
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xff7C7C7C),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Color(0xff181725),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Color(0xffE2E2E2)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          const Text(
                            "Review",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff181725),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: List.generate(
                              5,
                              (_) => const Icon(
                                Icons.star,
                                color: Color(0xffF3603F),
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Color(0xff181725),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 67,
                      child: ElevatedButton(
                        onPressed: () {
                          for (int i = 0; i < quantity; i++) {
                            widget.onAddToCart(widget.product);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff53B175),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
                          ),
                        ),
                        child: const Text(
                          "Add To Basket",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}