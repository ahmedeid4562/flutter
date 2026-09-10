import 'package:flutter/material.dart';
import '../model/product.dart';
import 'filter_screen.dart';

class SearchScreen extends StatefulWidget {
  final List<Product> cart;
  final Function(Product) onAddToCart;

  const SearchScreen({    super.key,    required this.cart,    required this.onAddToCart,  });
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController =
      TextEditingController(text: 'Egg');

  final List<Map<String, dynamic>> allProducts = [
    {
      'title': 'Egg Chicken Red',
      'subtitle': '4pcs, Price',
      'price': 1.99,
      'image': 'assets/images/image17.png'
    },
    {
      'title': 'Egg Chicken White',
      'subtitle': '180g, Price',
      'price': 1.50,
      'image': 'assets/images/image18.png'
    },
    {
      'title': 'Egg Pasta',
      'subtitle': '30gm, Price',
      'price': 15.99,
      'image': 'assets/images/image19.png'
    },
    {
      'title': 'Egg Noodles',
      'subtitle': '2L, Price',
      'price': 15.99,
      'image': 'assets/images/image20.png'
    },
    {
      'title': 'Mayonnais Eggless',
      'subtitle': '325ml, Price',
      'price': 4.99,
      'image': 'assets/images/image21.png'
    },
    {
      'title': 'Egg Noodles',
      'subtitle': '330g, Price',
      'price': 4.99,
      'image': 'assets/images/image22.png'
    },
  ];

  @override
  void dispose() {   _searchController.dispose();   super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.toLowerCase();
    final filteredProducts = allProducts
        .where((p) => p['title'].toString().toLowerCase().contains(query))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xffF2F3F2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search,
                              color: Color(0xff181725), size: 22),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (_) => setState(() {}),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff181725),
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search Store',
                              ),
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                setState(() => _searchController.clear());
                              },
                              child: const Icon(
                                Icons.cancel,
                                color: Color(0xff7C7C7C),
                                size: 18,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FilterScreen(),
                      ),
                    ),
                    icon: const Icon(
                      Icons.tune,
                      color: Color(0xff181725),
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: filteredProducts.isEmpty
                    ? const Center(
                        child: Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff7C7C7C),
                          ),
                        ),
                      )
                    : GridView.builder(
                        itemCount: filteredProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemBuilder: (context, index) {
                          final item = filteredProducts[index];

                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: const Color(0xffE2E2E2),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Image.asset(
                                      item['image'],
                                      fit: BoxFit.contain,
                                      errorBuilder: (_, __, ___) =>
                                          const Icon(
                                        Icons.egg_outlined,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        widget.onAddToCart(
                                          Product(
                                            image: item['image'],
                                            title: item['title'],
                                            description: item['subtitle'],
                                            price: item['price'],
                                            category: 'Eggs',
                                          ),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(17),
                                      child: Container(
                                        width: 42,
                                        height: 42,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff53B175),
                                          borderRadius:
                                              BorderRadius.circular(17),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}