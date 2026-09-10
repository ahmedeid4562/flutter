import 'package:flutter/material.dart';
import '../model/product.dart';
import 'beveragess_screen.dart';

class ExploreScreen extends StatefulWidget {
  final List<Product> cart;
  final Function(Product) onAddToCart;

  const ExploreScreen({    super.key,    required this.cart,    required this.onAddToCart,  });

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController searchController = TextEditingController();
  String searchText = '';

  final List<Map<String, String>> categories = [
    {'image': 'assets/images/image5.png', 'title': 'Fresh Fruits & Vegetables'},
    {'image': 'assets/images/image6.png', 'title': 'Cooking Oil & Ghee'},
    {'image': 'assets/images/image7.png', 'title': 'Meat & Fish'},
    {'image': 'assets/images/image8.png', 'title': 'Bakery & Snacks'},
    {'image': 'assets/images/image9.png', 'title': 'Dairy & Eggs'},
    {'image': 'assets/images/image10.png', 'title': 'Beverages'},
  ];

  List<Map<String, String>> get filteredCategories => categories
      .where((category) =>
          category['title']!.toLowerCase().contains(searchText.toLowerCase()))
      .toList();

  @override  void dispose() {    searchController.dispose();     super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Find Products',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff181725),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xffF2F3F2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) => setState(() => searchText = value),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Store',
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff7C7C7C),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(
                        'assets/icons/search.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: filteredCategories.isEmpty
                    ? const Center(
                        child: Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff7C7C7C),
                          ),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: filteredCategories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (context, index) {
                          final category = filteredCategories[index];

                          return InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: () {
                              if (category['title'] == 'Beverages') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BeveragessScreen(
                                      cart: widget.cart,
                                      onAddToCart: widget.onAddToCart,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffF2F3F2),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: const Color(0xffE2E2E2),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    category['image']!,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: Icon(
                                        Icons.image_not_supported,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Text(
                                      category['title']!,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff181725),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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