import 'package:flutter/material.dart';
import '../model/product.dart';
import '../widgets/item_card.dart';

class BeveragesScreen extends StatefulWidget {
  final List<Product> favourites;
  final Function(Product) onToggleFavourite;

  const BeveragesScreen({    super.key,    required this.favourites,    required this.onToggleFavourite,  });
  @override
  State<BeveragesScreen> createState() => _BeveragesScreenState();
}

class _BeveragesScreenState extends State<BeveragesScreen> {
  final TextEditingController searchController = TextEditingController();
  String searchText = '';

  final List<Product> beverages = [
    Product(
      image: 'assets/images/image11.png',
      title: 'Diet Coke',
      description: '355ml, Price',
      price: 1.99,
      category: 'Beverages',
    ),
    Product(
      image: 'assets/images/image12.png',
      title: 'Sprite Can',
      description: '325ml, Price',
      price: 1.50,
      category: 'Beverages',
    ),
    Product(
      image: 'assets/images/image13.png',
      title: 'Apple & Grape Juice',
      description: '2L, Price',
      price: 15.99,
      category: 'Beverages',
    ),
    Product(
      image: 'assets/images/image14.png',
      title: 'Orange Juice',
      description: '2L, Price',
      price: 15.99,
      category: 'Beverages',
    ),
    Product(
      image: 'assets/images/image15.png',
      title: 'Coca-Cola Can',
      description: '325ml, Price',
      price: 4.99,
      category: 'Beverages',
    ),
    Product(
      image: 'assets/images/image16.png',
      title: 'Pepsi Can',
      description: '325ml, Price',
      price: 4.99,
      category: 'Beverages',
    ),
  ];

  List<Product> get filteredBeverages {
    if (searchText.isEmpty) return beverages;

    return beverages.where((product) {
      return product.title.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  }

  void addToCart(Product product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} added to cart'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Beverages',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xff181725),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
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
                    hintStyle: const TextStyle(color: Color(0xff7C7C7C)),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Image.asset(
                        'assets/icons/search.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  itemCount: filteredBeverages.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.70,
                  ),
                  itemBuilder: (context, index) {
                    final product = filteredBeverages[index];

                    return ItemCard(
                      product: product,
                      width: double.infinity,
                      onAdd: () => addToCart(product),
                      favourites: widget.favourites,
                      onToggleFavourite: widget.onToggleFavourite,
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

