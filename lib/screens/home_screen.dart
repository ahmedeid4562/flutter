import 'package:flutter/material.dart';
import '../model/product.dart';
import '../widgets/grocery_section.dart';
import '../widgets/product_section.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<Product> cart;
  final Function(Product) onAddToCart;
  final List<Product> favourites;
  final Function(Product) onToggleFavourite;

  const HomeScreen({  super.key,  required this.cart,  required this.onAddToCart,  required this.favourites,  required this.onToggleFavourite,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> baseExclusive = [
    Product(
      image: "assets/images/92f1ea7dcce3b5d06cd1b1418f9b9413 3.png",
      title: "Organic Bananas",
      description: "7pcs, Price",
      price: 4.99,
      category: "Exclusive Offer",
    ),
    Product(
      image: "assets/images/Vector.png",
      title: "Red Apple",
      description: "1kg, Price",
      price: 4.99,
      category: "Exclusive Offer",
    ),
  ];

  final List<Product> baseBestSelling = [
    Product(
      image: "assets/images/pepper.png",
      title: "Bell Pepper Red",
      description: "1kg, Price",
      price: 4.99,
      category: "Best Selling",
    ),
    Product(
      image: "assets/images/pngfuel 3.png",
      title: "Ginger",
      description: "250gm, Price",
      price: 4.99,
      category: "Best Selling",
    ),
  ];

  final List<Product> baseGroceries = [
    Product(
      image: "assets/images/image3.png",
      title: "Beef Bone",
      description: "1kg, Price",
      price: 4.99,
      category: "Groceries",
    ),
    Product(
      image: "assets/images/image4.png",
      title: "Broiler Chicken",
      description: "1kg, Price",
      price: 4.99,
      category: "Groceries",
    ),
  ];

  List<Product> _repeatProducts(List<Product> baseList, int totalCount) {
    return List.generate(totalCount, (i) => baseList[i % baseList.length]);
  }

  @override
  Widget build(BuildContext context) {
    final exclusiveProducts = _repeatProducts(baseExclusive, 8);
    final bestSellingProducts = _repeatProducts(baseBestSelling, 8);
    final groceryProducts = _repeatProducts(baseGroceries, 8);

    return Material(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/Group.png",
                  width: 30,
                  height: 30,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.store,
                    size: 30,
                    color: Color(0xff53B175),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 18,
                    color: Color(0xff4C4F4D),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Dhaka, Banasree",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff4C4F4D),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(
                      cart: widget.cart,
                      onAddToCart: widget.onAddToCart,
                    ),
                  ),
                ),
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xffF2F3F2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Color(0xff7C7C7C)),
                      SizedBox(width: 10),
                      Text(
                        "Search Store",
                        style: TextStyle(
                          color: Color(0xff7C7C7C),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/images/banner.png",
                  width: double.infinity,
                  height: 115,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 115,
                    color: Colors.green.shade100,
                    child: const Center(child: Text("Banner")),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              ProductSection(
                title: "Exclusive Offer",
                showSeeAll: true,
                showArrow: false,
                products: exclusiveProducts,
                onAdd: widget.onAddToCart,
                favourites: widget.favourites,
                onToggleFavourite: widget.onToggleFavourite,
              ),
              const SizedBox(height: 25),
              ProductSection(
                title: "Best Selling",
                showSeeAll: true,
                showArrow: false,
                products: bestSellingProducts,
                onAdd: widget.onAddToCart,
                favourites: widget.favourites,
                onToggleFavourite: widget.onToggleFavourite,
              ),
              const SizedBox(height: 25),
              const GrocerySection(),
              const SizedBox(height: 15),
              ProductSection(
                title: "",
                showSeeAll: false,
                showArrow: false,
                products: groceryProducts,
                onAdd: widget.onAddToCart,
                favourites: widget.favourites,
                onToggleFavourite: widget.onToggleFavourite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}