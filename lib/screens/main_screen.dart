import 'package:flutter/material.dart';
import '../model/product.dart';
import 'account_screen.dart';
import 'explore_screen.dart';
import 'home_screen.dart';
import 'cart_screen.dart';
import 'favourite_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final List<Product> _cart = [];
  final List<Product> _favourites = [];

  void _addToCart(Product product) {
    setState(() => _cart.add(product));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} added to cart'),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xff53B175),
      ),
    );
  }

  void _toggleFavourite(Product product) {
    setState(() {
      if (_favourites.contains(product)) {
        _favourites.remove(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.title} removed from favourites'),
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else {
        _favourites.add(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.title} added to favourites'),
            duration: const Duration(seconds: 1),
            backgroundColor: const Color(0xff53B175),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        cart: _cart,
        onAddToCart: _addToCart,
        favourites: _favourites,
        onToggleFavourite: _toggleFavourite,
      ),
      ExploreScreen(cart: _cart, onAddToCart: _addToCart),
      CartScreen(cart: _cart, onAddToCart: _addToCart),
      FavouriteScreen(
        favourites: _favourites,
        onToggleFavourite: _toggleFavourite,
      ),
      const AccountScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: const Color(0xff53B175),
          unselectedItemColor: const Color(0xff181725),
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined),
              activeIcon: Icon(Icons.storefront),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/explore.png',
                width: 24,
                height: 24,
              ),
              activeIcon: Image.asset(
                'assets/icons/explore.png',
                width: 24,
                height: 24,
              ),
              label: 'Explore',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: 'Favourite',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}