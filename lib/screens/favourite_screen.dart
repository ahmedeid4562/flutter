import 'package:flutter/material.dart';
import '../model/product.dart';

class FavouriteScreen extends StatefulWidget {
  final List<Product> favourites;
  final Function(Product) onToggleFavourite;

  const FavouriteScreen({  super.key,   required this.favourites,   required this.onToggleFavourite, });

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  void showOrderFailed() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.close,
                    color: Color(0xff181725),
                    size: 25,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 5),
              Image.asset(
                'assets/images/image24.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 25),
              const Text(
                "Oops! Order Failed",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff181725),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Something went terribly wrong.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xff7C7C7C),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff53B175),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Please Try Again",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                ),
                child: const Text(
                  "Back to home",
                  style: TextStyle(
                    color: Color(0xff181725),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
          "Favourite",
          style: TextStyle(
            color: Color(0xff181725),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.favourites.isEmpty
                ? const Center(
                    child: Text(
                      "No favourites yet",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff7C7C7C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.favourites.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    itemBuilder: (context, index) {
                      final product = widget.favourites[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(0xffE2E2E2),
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              product.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xff181725),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    product.description,
                                    style: const TextStyle(
                                      color: Color(0xff7C7C7C),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\$${product.price.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xff181725),
                              ),
                            ),
                            const SizedBox(width: 15),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Color(0xff181725),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: const Color(0xff53B175),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: showOrderFailed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff53B175),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Test Failed Order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}