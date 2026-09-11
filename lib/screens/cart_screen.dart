import 'package:flutter/material.dart';
import '../model/product.dart';
import 'order_accepted_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cart;
  final Function(Product) onAddToCart;

  const CartScreen({ super.key,  required this.cart, required this.onAddToCart, });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String selectedPayment = '';

  Map<Product, int> get quantities {
    final result = <Product, int>{};

    for (final product in widget.cart) {
      result[product] = (result[product] ?? 0) + 1;
    }

    return result;
  }

  List<Product> get products => widget.cart.toSet().toList();

  double get total => quantities.entries.fold(
        0,
        (sum, item) => sum + item.key.price * item.value,
      );

  static const green = Color(0xff53B175);
  static const dark = Color(0xff181725);
  static const grey = Color(0xff7C7C7C);
  static const border = Color(0xffE2E2E2);

  @override
  Widget build(BuildContext context) {
    final items = products;
    final counts = quantities;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: dark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: items.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18, color: grey),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: items.length,
                    itemBuilder: (_, index) =>
                        _cartItem(items[index], counts[items[index]] ?? 1),
                  ),
                ),
                _checkoutButton(),
              ],
            ),
    );
  }

  Widget _cartItem(Product product, int quantity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: border)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            product.image,
            width: 70,
            height: 70,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.image, size: 70),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: dark,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          widget.cart.removeWhere((p) => p == product);
                        });
                      },
                      child: const Icon(Icons.close, color: Color(0xffB3B3B3)),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  product.description,
                  style: const TextStyle(color: grey, fontSize: 14),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _quantityButton(
                          Icons.remove,
                          () {
                            if (quantity > 1) {
                              setState(() => widget.cart.remove(product));
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            '$quantity',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: dark,
                            ),
                          ),
                        ),
                        _quantityButton(
                          Icons.add,
                          () => setState(
                            () => widget.onAddToCart(product),
                          ),
                          green,
                        ),
                      ],
                    ),
                    Text(
                      '\$${(product.price * quantity).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: dark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityButton(
    IconData icon,
    VoidCallback onTap, [
    Color color = grey,
  ]) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: border),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }

  Widget _checkoutButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () => _showCheckoutBottomSheet(context, total),
          style: ElevatedButton.styleFrom(
            backgroundColor: green,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 20),
              const Text(
                'Go to Checkout',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff489E67),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCheckoutBottomSheet(BuildContext context, double total) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Checkout',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: dark,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: dark),
                ),
              ],
            ),
            const Divider(color: border),
            _checkoutRow(
              'Delivery',
              'Select Method',
              () => _showDeliveryOptions(context),
            ),
            _checkoutRow(
              'Payment',
              null,
              () => _showPaymentOptions(context),
              Image.asset(
                'assets/images/image25.png',
                width: 32,
                height: 24,
                fit: BoxFit.contain,
              ),
            ),
            _checkoutRow(
              'Promo Code',
              'Pick discount',
              () => _showPromoCode(context),
            ),
            _checkoutRow(
              'Total Cost',
              '\$${total.toStringAsFixed(2)}',
              () {},
            ),
            const SizedBox(height: 20),
            const Text(
              'By placing an order you agree to our Terms And Conditions',
              style: TextStyle(color: grey, fontSize: 14),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() => widget.cart.clear());

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const OrderAcceptedScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                  ),
                ),
                child: const Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _checkoutRow(
    String title,
    String? text,
    VoidCallback onTap, [
    Widget? widget,
  ]) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    if (text != null)
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 16,
                          color: dark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (widget != null) widget,
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: dark,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Divider(color: border, height: 1),
      ],
    );
  }

  void _showDeliveryOptions(BuildContext context) {
    _showOptions(
      context,
      'Choose Delivery Method',
      [
        ['Standard Delivery', 'Delivered to your address'],
        ['Express Delivery', 'Fast delivery'],
      ],
    );
  }

  void _showPaymentOptions(BuildContext context) {
    _showOptions(
      context,
      'Choose Payment Method',
      [
        ['Credit / Debit Card', 'Pay securely by card'],
      ],
    );
  }

  void _showOptions(
    BuildContext context,
    String title,
    List<List<String>> options,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: dark,
              ),
            ),
            const SizedBox(height: 20),
            ...options.map(
              (option) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _optionTile(
                  title: option[0],
                  subtitle: option[1],
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPromoCode(BuildContext context) {
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          24,
          24,
          MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Promo Code',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: dark,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Enter promo code',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionTile({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: border),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: green,
              size: 25,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: dark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}