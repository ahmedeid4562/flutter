import 'package:flutter/material.dart';
import '../model/product.dart';

class BeveragessScreen extends StatelessWidget {
  final List<Product> cart;
  final Function(Product) onAddToCart;

  BeveragessScreen({super.key, required this.cart, required this.onAddToCart,});

  final List<Map<String, dynamic>> productsData = [
    {
      'title': 'Diet Coke',
      'subtitle': '355ml, Price',
      'price': 1.99,
      'image': 'assets/images/image11.png',
    },
    {
      'title': 'Sprite Can',
      'subtitle': '325ml, Price',
      'price': 1.50,
      'image': 'assets/images/image12.png',
    },
    {
      'title': 'Apple & Grape Juice',
      'subtitle': '2L, Price',
      'price': 15.99,
      'image': 'assets/images/image13.png',
    },
    {
      'title': 'Orange Juice',
      'subtitle': '2L, Price',
      'price': 15.99,
      'image': 'assets/images/image14.png',
    },
    {
      'title': 'Coca Cola Can',
      'subtitle': '325ml, Price',
      'price': 4.99,
      'image': 'assets/images/image15.png',
    },
    {
      'title': 'Pepsi Can',
      'subtitle': '330ml, Price',
      'price': 4.99,
      'image': 'assets/images/image16.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Beverages',
          style: TextStyle(
            color: Color(0xff181725),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: productsData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (context, index) {
          final item = productsData[index];

          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xffE2E2E2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      item['image'],
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.local_drink,
                        size: 50,
                        color: Color(0xff53B175),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item['title'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff181725),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['subtitle'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff7C7C7C),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item['price']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff181725),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final product = Product(
                          image: item['image'],
                          title: item['title'],
                          description: item['subtitle'],
                          price: item['price'],
                          category: 'Beverages',
                          quantity: 1,
                        );
                        onAddToCart(product);
                      },
                      borderRadius: BorderRadius.circular(17),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xff53B175),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 22),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

